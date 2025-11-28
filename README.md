# 🏥 Healthcare Cost & Utilization Analytics (2011-2021)

A comprehensive analytics project examining healthcare cost drivers, patient utilization patterns, provider performance, and DALY/QALY health outcomes using a curated data warehouse (Gold Layer). Including:
- **Exploratory Data Analysis (EDA)** 
- **Cost Driver Analysis** 
- **Patient Segmentation (Deciles / Cost Bands)** 
- **Provider Performance & Workload Analysis** 
- **DALY/QALY Outcome Study** 
- - **Executive‑level Power BI Dashboard** 
---

## 📂 Cấu trúc repo

```
healthcare-analytics/
├── README.md
│
├── sql-scripts/
│   ├── patient_EDA.sql
│   ├── claim_analysis.sql
│   ├── cost_driver_queries.sql
│   ├── provider_performance.sql
│   └── segmentation_DALY_QALY.sql
│
├── powerbi/
│   └── Healthcare_Executive_Dashboard.pbix
│
├── documentation/
│   ├── data_dictionary.md
│   ├── model_schema.png
│   └── executive_report.pdf


````

---

## 🛠️Tools
- **Database**: MS SQL Server  
- **Excel**: Report  
- **Visualization**: Power BI Desktop / Power BI Service  
- **Version control**: GitHub  

---

## Datawarehouse
Check this repo for info: https://github.com/huong-nguyen17/Health-Care-Warehouse-Project

### Dimensional Tables

```
| Table                   | Description                                     |
| ----------------------- | ----------------------------------------------- |
| `gold.dim_patient`      | Demographics, age, gender, location, DALY, QALY |
| `gold.dim_practitioner` | Practitioner profile & specialty                |
| `gold.dim_claim`        | Claim header details                            |
| `gold.dim_claimitem`    | Claim line metadata (procedure/service)         |
| `gold.dim_encounter`    | Encounter type and care setting                 |
| `gold.dim_observation`  | Observation code, category, units               |

````

---

### 2. Fact Tables
```
| Fact Table                        | Grain                     | Description                             |
| --------------------------------- | ------------------------- | --------------------------------------- |
| `gold.fact_claim`                 | Claim line                | NetValue, BilledValue, patient/provider |
| `gold.fact_encounter_observation` | Observation per encounter | Lab/vitals/survey values                |

```

---

### 🎯 Project Objectives

- **Build a strong analytical foundation for healthcare cost & utilization** 
- **Identify key cost drivers (procedures, providers, conditions)** 
- **Segment patients by cost intensity (deciles & cost bands)** 
- **Evaluate provider workload, cost efficiency, and hospital concentration** 
- **Analyze DALY & QALY across patient risk groups** 
- **Deliver insights via a professional Power BI executive dashboard** 
--------
### 🔍 Analytical Framework

 Data Quality Profiling
Row completeness checks

Missingness (DOB, gender, city)

Referential integrity validation

Outlier detection for lab/vital observations

Duplicate timestamps and claim/encounter IDs

2️⃣ Patient Population Profiling (2011–2021)
Highlights

1,473 unique patients

Largest group: ages 60–69

Gender split: 54.2% male / 45.8% female

Top cities: Winnipeg, Whitehorse, Halifax

DALY/QALY distribution used for burden/outcome analysis

3️⃣ Claims & Cost Analysis
140,716 claim lines

Total NetValue approx. $30M

Average NetValue ~ $120 per claim per month

Seasonal pattern:

Highest in March

Lowest in Sept–Nov

Cost concentration

Top 20% of patients = 61.3% of total costs

Strong Pareto curve

4️⃣ Observation & Encounter Analytics
Encounter class distribution

Ambulatory (AMB): 80–95%

Emergency (EMER) & Inpatient (INP): minority share

Top observation categories

Lab (CBC, metabolic panel)

Vital Signs

Surveys / Health questionnaires

Outlier clusters in BP, BMI, glucose correlate with high‑cost groups.

🧠 Executive Insights
⭐ Major Cost Drivers
Prenatal care procedures > $34M

Cardiac surgeries/interventions: $24K–$49K per case

Dialysis & immunotherapy = recurring high‑spend categories

Vaccination & routine exams = high‑volume, low‑cost workload

⭐ Provider Performance
Top 5 hospitals contribute the largest share of costs

Remote facilities show very high per‑claim average (> $4,500)

Primary care = high‑volume, low‑cost backbone of the system

Mental health & rehab providers = moderate spend but high strategic value

⭐ Patient Segmentation
Top 10% = 51.64% of cost

Bottom 50% = ~5%

Highest‑cost demographic = Males 65+

Younger high‑cost groups exist (18–49), but with lower claim intensity

QALY increases with cost → high‑cost care yields meaningful health gains



---

### 📈 Power BI Dashboard

<img width="1115" height="627" alt="image" src="https://github.com/user-attachments/assets/7cc351d6-fab2-4053-9eb0-76c4258f7877" />
---
### 📊 Report
Check: https://github.com/huong-nguyen17/HealthCare-Project/tree/main/docs
---
### 🚀 Future Enhancements
Predictive modeling for high‑cost patient forecasting

Readmission risk modeling

Provider efficiency scoring using ML

NLP for clinical notes (if available)

---

## 📜 License

[MIT](/LICENSE)

---

## 📬 Contact: [https://www.linkedin.com/in/huong-tris-n-847067111/]

