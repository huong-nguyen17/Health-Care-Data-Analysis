#🏥 Healthcare Cost & Utilization Analytics Project
A Comprehensive SQL‑Based Data Analysis for Executive Insights (2011–2021)

📌 Overview
This project delivers an end‑to‑end analytical investigation of healthcare cost patterns, patient utilization behaviour, provider performance, and population health metrics using a curated data warehouse.
The work includes:

---------
Exploratory Data Analysis (EDA)

Cost driver analytics

Patient segmentation (deciles, risk tiers)

Provider workload & efficiency assessment

DALY/QALY health outcome evaluation

Executive‑ready insights and dashboards
-----
Tools Used: MS SQL Server, Power BI
Source Warehouse: Health‑Care‑Warehouse‑Project
----
📂 Data Model & Tables
All analysis is built on the Gold Layer (clean, conformed, analysis‑ready).

Dimensional Tables
Table	Description
gold.dim_patient	Demographics, DOB, gender, geographic fields, DALY, QALY
gold.dim_practitioner	Practitioner identification & specialty
gold.dim_claim	Claim headers, status, timestamps
gold.dim_claimitem	Line‑level claim details (procedure/service metadata)
gold.dim_encounter	Encounter type, care setting
gold.dim_observation	Observation metadata (code, category, units)
Fact Tables
Fact Table	Grain	Description
gold.fact_claim	Claim line	NetValue, BilledValue, PatientID, ProviderID
gold.fact_encounter_observation	Observation within an encounter	Clinical measurement/value tied to patient & encounter
This model follows a star‑schema pattern, enabling optimized analytical queries and consistent joins.

🎯 Project Objectives
Build a reliable analytical foundation for healthcare cost & utilization insights

Identify major financial drivers across procedures, products, practitioners, and patient cohorts

Segment patients by cost burden (deciles, cost bands)

Analyze provider performance and workload impact

Evaluate health outcomes using DALY & QALY

Provide actionable findings for executive decision‑making

🔍 Analytical Framework
1. Data Quality Profiling
Row‑level completeness checks across all tables

Validation of PatientID & PractitionerID referential integrity

Distribution and missingness for demographic attributes

Numeric validation for observation values

Deduplication checks on claims & encounter keys

2. Patient Population Profiling (2011–2021)
Age segmentation & decile distribution

Gender ratio and marital status distribution

Geographic spread (city, state/province)

Race/Ethnicity & language distribution (12 languages represented)

DALY & QALY health burden distribution

Key Highlights

Dataset includes 1,473 unique patients

Largest population segment: patients aged 60–69

Gender split: 54.2% male / 45.8% female

Top cities: Winnipeg, Whitehorse, Halifax

3. Claim & Cost Analysis (Core Financial Insights)
Coverage
140,716 claim lines

Claim data range: 1911 → 2021 (analysis focuses on 2011–2021)

Total NetValue processed: ~$30M

Patterns Identified
Stable average NetValue per claim (~$120 monthly)

Seasonal behavior: consistent peak in March, trough in Sept–Nov

High cost concentration:

Top 20% of patients = 61.3% of total cost

Strong Pareto pattern consistent with real healthcare systems

4. Observation & Encounter Analytics
Encounter Frequency
Ambulatory care represents 80–95% of all encounters

Sharp shifts observed during pandemic years

Observation Trends
Most frequent categories:
Lab, Vital Signs, Survey/Questionnaire

High‑frequency tests: metabolic panel, CBC

Specialized clusters: cancer metrics, newborn indicators

Several outlier groups (BMI, blood pressure), relevant for high‑cost cohorts

🧠 Key Findings (Executive Level)
⭐ High‑Cost Drivers
Prenatal care (e.g., fetal heart monitoring, uterine measurements) exceeds $34M

Cardiology interventions (CABG, PCI, cardioversion, thrombectomy) range $24K–$49K per case

Dialysis & immunotherapy = recurring high‑spend categories

Vaccinations & routine exams = high-volume, low-cost services

⭐ Provider Performance
Top 5 hospitals contribute significant majority of total cost

Remote facilities show unusually high average claim cost (> $4,500)

Primary care = high-volume, low-cost backbone

Mental health & rehabilitation sites show moderate spend but high strategic value

⭐ Patient Segmentation Insights
Top 10% = 51.64% of spend

Bottom 50% = ~5% of spend

Males aged 65+ are the highest-cost demographic

Younger high-cost patients (18–49) exist but with lower claim intensity

Females 35–49 show high total cost due to population size, not extreme individual cost

Cost appropriately aligns with disease burden (DALY) and QALY improvement

📈 Visual Dashboard (Power BI)
The final executive dashboard includes:

Executive Summary

Total NetValue trend

Monthly claim patterns

Top cost drivers

High‑cost cohort overview

Cost Driver Analysis

Procedure cost ranking

Product/service categories

Zero-cost service flags

High-impact cardiology events

Provider Performance

Provider workload distribution

Avg cost per claim by site

Rural/remote cost anomalies

Practitioner encounter volumes

Patient Segmentation

Cost deciles

DALY/QALY by cost bands

Claim line intensity

Demographic heatmap of high-cost groups

📦 Repository Structure
/sql-scripts
    ├── patient_EDA.sql
    ├── claim_analysis.sql
    ├── cost_driver_queries.sql
    ├── provider_performance.sql
    └── segmentation_DALY_QALY.sql

/powerbi
    ├── Healthcare_Executive_Dashboard.pbix

/documentation
    ├── data_dictionary.md
    ├── model_schema.png
    └── executive_report.pdf

README.md  (this file)
🚀 Future Enhancements
Predictive modeling (high-cost patient forecasting)

Readmission risk model (using encounters/observations)

NLP on clinical notes (if available)

Provider efficiency scoring using advanced ML

