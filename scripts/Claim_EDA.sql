select *
from [gold].[fact_claim]

--total claims
select distinct count(claimid) as total_claims
from [gold].[fact_claim]

--claims based on  claim type
select claimtype, count(*) as total_claims
from [gold].[fact_claim]
group by claimtype

--stats
SELECT
    COUNT(*) AS NumClaimLines,
    COUNT(DISTINCT ClaimID) AS NumClaims,
    COUNT(DISTINCT PatientID) AS NumClaimPatients,
    SUM(TotalBilled) AS TotalBilled,
    SUM(NetValue)    AS TotalNetValue,
    AVG(NetValue)    AS AvgNetValue
FROM gold.fact_claim;

-- Date range
SELECT
    MIN(CreatedDate) AS MinCreatedDate,
    MAX(CreatedDate) AS MaxCreatedDate,
    MIN(BillablePeriodStart) AS MinBillableStart,
    MAX(BillablePeriodEnd)   AS MaxBillableEnd
FROM gold.fact_claim;

-- Monthly trend
SELECT
    MONTH(CreatedDate) AS Month,
    SUM([TotalBilled]) AS TotalBills,
    COUNT(*)      AS NumClaimLines
FROM gold.fact_claim
GROUP BY MONTH(CreatedDate)
ORDER BY Month;
--total bills by service
SELECT TOP 20
    code,
    product_service,
    COUNT(*) AS NumLines,
    SUM([TotalBilled]) AS TotalBills
FROM gold.fact_claim
GROUP BY code, product_service
ORDER BY TotalBills DESC;
