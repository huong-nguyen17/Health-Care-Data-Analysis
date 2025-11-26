# Health-Care-EDA #
Tools Used: MS SQL Server
Tables Used: gold.dim_patient, gold.dim_practitioner, gold.fact_claim, gold.fact_observation_encounter
1. Objective
  The objective of this project was to perform an in‑depth exploratory data analysis (EDA) across patient, practitioner, claim, and observation data to understand data quality, population characteristics, cost distributions, and early utilization signals. This foundational analysis prepares the analytical environment for subsequent cost‑driver analysis, practitioner performance assessment, population health insights, and predictive modeling used in the final executive dashboard.

3. Data Sources & Structure
   
The analysis was conducted on curated gold‑layer views representing a cleaned, conformed dimensional model:
gold.dim_patient – demographic and health outcome attributes (e.g., gender, birthdate, DALY, QALY).
gold.dim_practitioner – practitioner profile and utilization indicators.
gold.fact_claim – line‑level financial detail for health insurance claims including billed and net values.
gold.fact_observation_encounter – clinical observations linked to encounters, including observation codes, values, and encounter types.
This star‑schema–like structure supports efficient analytical querying and ensures consistent joins for downstream reporting.

3. EDA Approach
✔ 3.1 Data Quality Assessment
Row counts validation across all tables
Missingness checks (birthdate, gender, city, observation values)
Patient and practitioner ID conformity between dimensions and facts
Numeric data type validation for observation values

✔ 3.2 Patient Population Profiling
Age distribution (decile groups)
Gender split
Geographic breakdown (city, state)

✔ 3.3 Claims Utilization Profiling
Date coverage of claim data
Monthly NetValue trend
Total billed vs. net amount
High‑level product/service categorization
Early cost concentration pattern (Pareto curve)

✔ 3.4 Observation & Encounter Profiling
Top observation categories
Most frequent observation codes
Encounter types & encounter classes
Numeric value ranges and outlier identification

4. Key Findings
This project collected data from 1911 to 2021. 
4.1 Population & Demographics
- The dataset contains 1473 unique patients, with the largest age segments in their 60s with 212 patients.
- The oldest patient is 115 while the youngest is 4.
- Gender distribution is approximately 45.8% female, 54.2% male.
- Based on marital status, married patients are the highest while single is the lowest.
- There are various ethic and race from patients as 12 languages are listed from patients.
- Top 3 cities that patients resident are Winnipeg, Whitehourse and Halifax.
4.2 Claims & Cost Patterns
- Claim data spans from 1911-09-19 to 2021-05-12 with consistent monthly volume with total of 140716 claims.
- Total NetValue billed during the period: ~$30M.
- Average claim line NetValue: $908.
- Jan and Feb are normally rising and peak in March, slowest in September.
Top 20% of patients account for 61.3% of total cost, confirming typical high‑cost concentration patterns.
4.3 Observation & Encounter Findings
- Most common observations category include: lab, vital-signs and survey.
- Encounter types with highest frequency: general examination, hospital admission for isolation.
- Certain observation values (e.g., BMI, systolic BP) show outlier clusters which may correlate with higher cost groups in later analysis. 
