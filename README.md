# Faith Specialist Hospital Performance Analysis

**Determining Factors Affecting Discharge Against Medical Advice (DAMA)**

A SQL and Power BI project analyzing patient demographics, chronic illness burden, lifestyle factors, and departmental workload to explain rising DAMA rates and mortality at a specialist hospital.

## 📊 The Dashboard

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/0842fe93-cdbe-42f2-bfff-baf97287af50" />

🔗 [Explore the interactive dashboard](https://app.powerbi.com/view?r=eyJrIjoiMDJkNGMxNTItMWIzMS00MzhiLWEyMmUtZGQyN2Y3M2QxZGQ3IiwidCI6ImJlNTQ4NDEyLWYxYzQtNDcyYi04OGE4LWQ2NzJlNWM4MzhiMyJ9)

📖 [Read the full write-up on Medium](https://medium.com/@aruaoluchilaw/faith-specialist-hospital-a-performance-dashboard-on-discharge-against-medical-advice-chronic-5e3f63087677)

## Problem Statement

Faith Specialist Hospital had accumulated years of patient data; demographics, admissions, chronic illness records, lifestyle history, and outcomes but no unified way to act on it. Management identified three concerning trends:

-A rising number of patients being discharged against medical advice

-A growing chronic illness burden across the patient population

-An elevated mortality rate concentrated in specific patient groups

This project turns that raw data into a diagnostic: who is at risk, what drives DAMA, and where hospital resources are under the most strain.

## Key Findings

-Sepsis is the leading cause of death (75 cases), consistent across every age group, with the Elderly carrying the highest overall mortality risk.

-Financial Constraint dominates DAMA cases (243 of recorded reasons), linked directly to occupation: Traders, Farmers, Retirees, and Students are discharged against medical advice most frequently.

-Stroke and Chronic Kidney Disease are the most prevalent chronic conditions (347 and 324 cases respectively).

-Alcohol use shows the widest DAMA/mortality gap of 26.57% DAMA rate vs. 14.69% mortality while Tobacco is the only factor where mortality risk exceeds DAMA risk.

-Emergency Medicine, Nephrology, Cardiology, and General Surgery carry the hospital's heaviest combined DAMA and mortality burden.

## Recommendations

-Build a financial support pathway for at-risk occupations.

-Expand geriatric care resourcing.

-Launch lifestyle-focused health programs (alcohol, NSAID use).

-Increase oversight in high-acuity departments.

-Deliver chronic illness management education.

## Repository Contents

| File | Description |
|---|---|
| `Faith_Hospital_Dama_Documentation.docx` | Full project documentation with detailed methodology and findings |
| `Faith_Hospital_Dama_Query.sql` | SQL queries used for the DAMA and mortality analysis |

## Tools Used

SQL — data cleaning, aggregation, exploratory analysis.

Power BI — dashboard design, DAX measures, interactive reporting.
