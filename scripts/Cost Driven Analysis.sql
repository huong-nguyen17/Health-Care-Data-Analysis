-------------------------------
---Cost Analysis---------------

--Overview

SELECT
    YEAR(CreatedDate) AS Year,
    MONTH(CreatedDate) AS Month,
    DATENAME(MONTH, CreatedDate) AS MonthName,
    COUNT(*) AS NumClaimLines,
    SUM(TotalBilled) AS TotalBilled,
    SUM(NetValue) AS TotalNetValue,
    AVG(NetValue) AS AvgNetValue
FROM gold.fact_claim
WHERE CreatedDate >= '2011-01-01'
GROUP BY YEAR(CreatedDate), MONTH(CreatedDate), DATENAME(MONTH, CreatedDate)
ORDER BY Year, Month;

--product/service driven cost
SELECT
    code, product_service, COUNT(*) AS NumLines,
    SUM(NetValue) AS TotalNetValue,
    AVG(NetValue) AS AvgNetValue
FROM gold.fact_claim
WHERE CreatedDate >= '2011-01-01'
GROUP BY code, product_service
ORDER BY TotalNetValue DESC

--provider driven cost 
SELECT
    ProviderName,
    COUNT(*) AS NumLines,
    SUM(NetValue) AS TotalNetValue,
    AVG(NetValue) AS AvgNetValue
FROM gold.fact_claim
WHERE CreatedDate >= '2011-01-01'
GROUP BY ProviderName
ORDER BY TotalNetValue DESC

--patient driven cost
-- 1) Aggregate cost & utilization per patient
WITH patient_cost AS (
    SELECT
        fc.PatientID,
        COUNT(*) AS NumClaimLines,
        SUM(fc.NetValue) AS TotalNetValue,
        AVG(fc.NetValue) AS AvgNetValue,
        MIN(fc.BillablePeriodStart) AS FirstServiceDate,
        MAX(fc.BillablePeriodEnd)   AS LastServiceDate
    FROM gold.fact_claim AS fc
	WHERE CreatedDate >= '2011-01-01'
    GROUP BY fc.PatientID
),

-- 2) Enrich with demographics & DALY/QALY
patient_enriched AS (
    SELECT
        p.PatientID,
        p.Gender,
        p.BirthDate,
        p.MaritalStatus,
        p.City,
        p.State,
        p.Disability_years AS DALY,
        p.Quality_years AS QALY,
        DATEDIFF(YEAR, p.BirthDate, GETDATE()) AS Age,
        pc.NumClaimLines,
        pc.TotalNetValue,
        pc.AvgNetValue,
        pc.FirstServiceDate,
        pc.LastServiceDate
    FROM gold.dim_patient AS p
    JOIN patient_cost AS pc
        ON p.PatientID = pc.PatientID
)

SELECT *
FROM patient_enriched;

--Cost Segmentation
WITH patient_cost AS (
    SELECT
        fc.PatientID,
        SUM(fc.NetValue) AS TotalNetValue,
        COUNT(*) AS NumClaimLines
    FROM gold.fact_claim AS fc
	WHERE CreatedDate >= '2011-01-01'
    GROUP BY fc.PatientID
),
patient_segmented AS (
    SELECT
        pc.*,
        NTILE(10) OVER (ORDER BY pc.TotalNetValue DESC) AS CostDecile,
        PERCENT_RANK() OVER (ORDER BY pc.TotalNetValue) AS CostPercentRank
    FROM patient_cost AS pc
)

SELECT
    CostDecile,
    COUNT(*) AS NumPatients,
    SUM(TotalNetValue) AS TotalNetValue,
    SUM(TotalNetValue) * 1.0 /
        SUM(SUM(TotalNetValue)) OVER () AS PctOfTotalCost,
    SUM(NumClaimLines) AS TotalClaimLines
FROM patient_segmented
GROUP BY CostDecile
ORDER BY CostDecile;  -- 1 = highest cost, 10 = lowest

--Age & Gender profile of high-cost patients
WITH patient_cost AS (
    SELECT
        fc.PatientID,
        SUM(fc.NetValue) AS TotalNetValue,
        COUNT(*) AS NumClaimLines
    FROM gold.fact_claim AS fc
	WHERE CreatedDate >= '2011-01-01'
    GROUP BY fc.PatientID
),
patient_segmented AS (
    SELECT
        pc.*,
        NTILE(10) OVER (ORDER BY pc.TotalNetValue DESC) AS CostDecile
    FROM patient_cost AS pc
),
patient_enriched AS (
    SELECT
        ps.PatientID,
        ps.TotalNetValue,
        ps.NumClaimLines,
        ps.CostDecile,
        p.Gender,
        p.BirthDate,
        p.Disability_years,
        p.Quality_years,
        DATEDIFF(YEAR, p.BirthDate, GETDATE()) AS Age
    FROM patient_segmented AS ps
    JOIN gold.dim_patient AS p
        ON ps.PatientID = p.PatientID
),
patient_banded AS (
    SELECT
        *,
        CASE 
            WHEN Age < 18 THEN '<18'
            WHEN Age BETWEEN 18 AND 34 THEN '18-34'
            WHEN Age BETWEEN 35 AND 49 THEN '35-49'
            WHEN Age BETWEEN 50 AND 64 THEN '50-64'
            WHEN Age BETWEEN 65 AND 79 THEN '65-79'
            ELSE '80+'
        END AS AgeBand
    FROM patient_enriched
)

SELECT
    CostDecile,
    AgeBand,
    Gender,
    COUNT(*) AS NumPatients,
    SUM(TotalNetValue) AS TotalNetValue,
    AVG(TotalNetValue) AS AvgCostPerPatient,
    AVG(NumClaimLines) AS AvgClaimLinesPerPatient
FROM patient_banded
WHERE CostDecile = 1  -- focus on high-cost patients
GROUP BY CostDecile, AgeBand, Gender
ORDER BY CostDecile, AgeBand, Gender;
--DALY vs QALY
WITH patient_cost AS (
    SELECT
        fc.PatientID,
        SUM(fc.NetValue) AS TotalNetValue
    FROM gold.fact_claim AS fc
	WHERE CreatedDate >= '2011-01-01'
    GROUP BY fc.PatientID
),
patient_enriched AS (
    SELECT
        p.PatientID,
        p.Disability_years,
        p.Quality_years,
        pc.TotalNetValue
    FROM gold.dim_patient AS p
    JOIN patient_cost AS pc
        ON p.PatientID = pc.PatientID
    WHERE p.Disability_years IS NOT NULL
       OR p.Quality_years IS NOT NULL
),
patient_banded AS (
    SELECT
        *,
        CASE 
            WHEN TotalNetValue < 1000 THEN '<1K'
            WHEN TotalNetValue BETWEEN 1000 AND 9999 THEN '1K-10K'
            WHEN TotalNetValue BETWEEN 10000 AND 49999 THEN '10K-50K'
            ELSE '50K+'
        END AS CostBand
    FROM patient_enriched
)

SELECT
    CostBand,
    COUNT(*) AS NumPatients,
    AVG(TotalNetValue) AS AvgCost,
    AVG(Disability_years) AS AvgDALY,
    AVG(Quality_years) AS AvgQALY
FROM patient_banded
GROUP BY CostBand
ORDER BY 
    CASE CostBand
        WHEN '<1K' THEN 1
        WHEN '1K-10K' THEN 2
        WHEN '10K-50K' THEN 3
        ELSE 4
    END;
