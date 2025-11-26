select *
from [gold].[dim_practitioner]

--total practioners
select count(*)
from [gold].[dim_practitioner]

--practitioner segmentation
select state,city, count(*) as total_practitioners
from [gold].[dim_practitioner]
group by state,city
order by state,total_practitioners desc

--encounters by gender
SELECT
    gender,
    SUM(CAST(utilizationencounters AS INT)) AS total_encounters,
    ROUND((CAST(SUM(CAST(utilizationencounters AS INT)) AS DECIMAL(18, 2)) * 100.0) / 
        SUM(SUM(CAST(utilizationencounters AS INT))) OVER (),
        2) AS percent_of_total
FROM 
    [gold].[dim_practitioner]
GROUP BY 
    gender
ORDER BY 
    total_encounters DESC;
