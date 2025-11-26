
--patient observation stat
SELECT ObservationCode, ObservationText,
       COUNT(*) AS ObsCount,
       AVG(TRY_CAST(Value AS FLOAT)) AS AvgValue,
       MIN(TRY_CAST(Value AS FLOAT)) AS MinValue,
       MAX(TRY_CAST(Value AS FLOAT)) AS MaxValue
FROM gold.fact_observation_encounter
WHERE TRY_CAST(Value AS FLOAT) IS NOT NULL
GROUP BY ObservationCode, ObservationText
ORDER BY ObsCount DESC;

-- Counts by observation category/type
SELECT ObservationCategory, COUNT(*) AS ObsCount
FROM gold.fact_observation_encounter
GROUP BY ObservationCategory
ORDER BY ObsCount DESC;

SELECT ObservationCode, ObservationText, COUNT(*) AS ObsCount
FROM gold.fact_observation_encounter
GROUP BY ObservationCode, ObservationText
ORDER BY ObsCount DESC;

-- Date range for EffectiveDate
SELECT
    MIN(EffectiveDate) AS MinEffectiveDate,
    MAX(EffectiveDate) AS MaxEffectiveDate
FROM gold.fact_observation_encounter;

-- EncounterClass & type
SELECT EncounterClass, COUNT(*) AS NumEncounters
FROM gold.fact_observation_encounter
GROUP BY EncounterClass
ORDER BY NumEncounters DESC;

SELECT encounter_code, encounter_text, COUNT(*) AS NumEncounters
FROM gold.fact_observation_encounter
GROUP BY encounter_code, encounter_text
ORDER BY NumEncounters DESC;

