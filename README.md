🏥 Healthcare Cost & Utilization Analytics Project
A Comprehensive SQL + Power BI Analytical Review (2011–2021)
📌 Overview
This project provides an end‑to‑end analysis of healthcare cost behavior, patient utilization patterns, provider performance, and health‑outcome metrics (DALY & QALY). It is built on a curated enterprise data warehouse using gold‑layer dimensional tables.

Deliverables include:

✔ Exploratory Data Analysis (EDA)

✔ Cost driver analytics

✔ Provider workload & performance review

✔ Patient cost segmentation (deciles & cost bands)

✔ DALY / QALY outcome analysis

✔ Executive‑focused Power BI dashboard

Tools Used: MS SQL Server, Power BI
Source Warehouse: Health‑Care‑Warehouse‑Project

📂 Data Model & Tables
Dimensional Tables
Table	Description
gold.dim_patient	Demographics, DOB, gender, location, DALY, QALY
gold.dim_practitioner	Practitioner details & specialty
gold.dim_claim	Claim headers, timestamps, status
gold.dim_claimitem	Line‑level claim metadata (procedure/service)
gold.dim_encounter	Encounter type (AMB/EMER/INP), care setting
gold.dim_observation	Observation categories, units & codes
Fact Tables
Fact Table	Grain	Description
gold.fact_claim	Claim line	Billed value, net value, patient & provider keys
gold.fact_encounter_observation	Observation-per-encounter	Clinical measurements tied to patient & encounter
The warehouse follows a clean star schema optimized for analytical workloads.

🎯 Project Objectives
Build a reliable analytical foundation for healthcare cost insights

Identify major cost drivers (procedures, facilities, chronic diseases)

Segment patients by cost burden (deciles & cost bands)

Analyze provider performance & workload concentration

Evaluate population health outcomes using DALY & QALY

Deliver executive‑ready visuals and summaries

🔍 Analytical Framework
1️⃣ Data Quality Profiling
Row completeness checks

Missingness analysis (DOB, gender, location)

Validation of PatientID & PractitionerID integrity

Outlier checks for numeric observation values

Deduplication for claims & encounter keys

2️⃣ Patient Population Profiling (2011–2021)
Key analyses include:

Age distribution & decile segmentation

Gender and marital status

Geographic distribution

Race/ethnicity & language (12 languages represented)

DALY & QALY health burden

Highlights:

1,473 unique patients

Largest age group: 60–69

Gender split: 54.2% male / 45.8% female

Top cities: Winnipeg, Whitehorse, Halifax

3️⃣ Claims & Cost Analysis
140,716 total claim lines

~$30M total NetValue

Avg monthly NetValue per claim ≈ $120

Seasonal trend:

Peak: March

Lowest: September–November

Cost concentration:

Top 20% patients = 61.3% of total cost

Clear Pareto pattern

4️⃣ Observation & Encounter Analytics
Encounter classes:

Ambulatory (AMB): 80–95%

EMER + INP: stable minority share

Top observation categories:

Laboratory

Vital Signs

Survey / Questionnaire

Notable findings:

Outlier clusters in BP, BMI, glucose map to high‑cost patients.

🧠 Executive Key Findings
⭐ Major Cost Drivers
Prenatal care procedures exceed $34M

Cardiology: CABG, PCI, cardioversion, thrombectomy costing $24K–$49K

Dialysis & immunotherapy = high recurring spend

Preventive care = high-volume, low-cost backbone

⭐ Provider Performance
Top 5 hospitals account for majority of total spend

Remote locations show extremely high cost per claim (> $4,500)

Primary care = high-volume, low-cost stabilizer

Mental health & rehab = moderate spend, high strategic value

⭐ Patient Segmentation
Top 10% = 51.64% of cost

Bottom 50% = ~5%

Males 65+ = highest-cost demographic

High-cost patients yield largest QALY improvements

DALY increases sharply across cost bands

📈 Power BI Dashboard
Includes:

Executive summary

Cost-driver analytics

Provider performance heatmaps

Patient segmentation (deciles, cost bands)

DALY/QALY value insights

Encounter & observation trends

(Add screenshot here if desired)

📦 Repository Structure
/sql-scripts
    ├── patient_EDA.sql
    ├── claim_analysis.sql
    ├── cost_driver_queries.sql
    ├── provider_performance.sql
    └── segmentation_DALY_QALY.sql

/powerbi
    └── Healthcare_Executive_Dashboard.pbix

/documentation
    ├── data_dictionary.md
    ├── model_schema.png
    └── executive_report.pdf

README.md
🚀 Future Enhancements
Predictive modeling for high‑cost patients

Readmission risk & encounter forecasting

NLP on clinical notes (if available)

Provider efficiency scoring (ML‑based)

