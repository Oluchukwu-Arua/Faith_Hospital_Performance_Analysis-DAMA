--ANALYSIS AND INSIGHT GENERATION.

--1.Analyze patient demographics in relation to hospital outcomes.
--Snapshot of patient demographics in relation to hospital outcome.
SELECT p.age, p.sex, p.occupation, p.level_of_education, p.marital_status, a.dead, a.cause_of_death
FROM patients p
JOIN admissions a ON p.pt_id = a.pt_id
--Determine the main cause of death for age groups
WITH AgeGroup AS (
    SELECT CASE
            WHEN p.AGE BETWEEN 0 AND 20 THEN 'Young Adults'
            WHEN p.AGE BETWEEN 21 AND 40 THEN 'Adults'
            WHEN p.AGE BETWEEN 41 AND 50 THEN 'Middle-Age Adults'
            WHEN p.AGE BETWEEN 51 AND 60 THEN 'Older Adults'
            ELSE 'Elderly'
        END AS Age_Group,
        a.Cause_of_Death,COUNT(a.admission_id) AS Death_Count
    FROM patients p
    JOIN admissions a ON p.pt_id = a.pt_id
    WHERE a.dead = 'Yes'
    GROUP BY Age_Group, a.cause_of_death), 
MainCause AS (SELECT 
        Age_Group, cause_of_death,
        Death_Count,
        ROW_NUMBER() OVER (PARTITION BY Age_Group ORDER BY Death_Count DESC) AS Main_Cause_of_Death
    FROM AgeGroup)
SELECT 
    Age_Group, cause_of_death AS Highest_Cause_of_Death, Death_Count
FROM MainCause
WHERE Main_Cause_of_Death = 1
ORDER BY Age_Group;

--2.Identify common reasons for discharge against medical advice (DAMA)
--Identify the general reasons for DAMA.
SELECT reason_for_dama, COUNT(admission_id) AS DAMA_count
FROM admissions 
WHERE DAMA = 'Yes'
GROUP BY reason_for_dama
ORDER BY DAMA_count DESC

--Occupation vs DAMA
SELECT p.occupation, COUNT(a.admission_id) AS DAMA_Count
FROM patients p
JOIN admissions a ON p.pt_id = a.pt_id
WHERE a.DAMA = 'Yes'
GROUP BY p.OCCUPATION
ORDER BY DAMA_Count DESC

--3.Examine the prevalence and impact of chronic illnesses among patients.
--Prevalence of chronic illnesses among patients
SELECT 
    COUNT(DISTINCT pt_id) AS Total_Patients,
    SUM(CASE WHEN ckd = 'Yes' THEN 1 ELSE 0 END) AS ckd_Count,
    SUM(CASE WHEN dm = 'Yes' THEN 1 ELSE 0 END) AS dm_Count,
    SUM(CASE WHEN stroke = 'Yes' THEN 1 ELSE 0 END) AS stroke_Count,
    SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END) AS cancer_Count,
    SUM(CASE WHEN pud = 'Yes' THEN 1 ELSE 0 END) AS pud_Count
FROM admissions 

--Impact of chronic illnesses among patients
SELECT 
    CASE 
        WHEN ckd = 'Yes' THEN 'Chronic Kidney Disease'
        WHEN dm = 'Yes' THEN 'Diabetes Mellitus'
        WHEN stroke = 'Yes' THEN 'Stroke'
        WHEN cancer = 'Yes' THEN 'Cancer'
        WHEN pud = 'Yes' THEN 'Peptic Ulcer Disease'
        ELSE 'No Chronic Illness'
    END AS Chronic_Illness,
    COUNT(pt_id) AS Total_Patients,
    SUM(CASE WHEN DAMA = 'Yes' THEN 1 ELSE 0 END) AS DAMA_Count,
    SUM(CASE WHEN dead = 'Yes' THEN 1 ELSE 0 END) AS Death_Count
FROM admissions 
GROUP BY Chronic_Illness
ORDER BY Total_Patients DESC

--4. Assess the impact of lifestyle factors on hospital outcomes.
SELECT rf.alcohol_hx, rf.tobacco_hx, rf.nsaid_use,
    COUNT(a.pt_id) AS Total_Patients,
    SUM(CASE WHEN a.DAMA = 'Yes' THEN 1 ELSE 0 END) AS DAMA_Count,
    SUM(CASE WHEN a.DEAD = 'Yes' THEN 1 ELSE 0 END) AS Death_Count
FROM risk_factors rf
JOIN admissions a ON rf.pt_id = a.pt_idB
GROUP BY rf.alcohol_hx, rf.tobacco_hx, rf.nsaid_use
ORDER BY Total_Patients DESC

--5. Evaluate the performance of the doctors based on specialization and workload.
--Patient distribution against specialization.
SELECT d.specialization, COUNT(a.pt_id) AS patient_count
FROM doctors d
JOIN admissions a ON d.doctor_id = a.doctor_id
GROUP BY d.specialization
ORDER BY patient_count DESC

--Evaluating hospital outcomes based on specialization
SELECT 
    d.specialization,
    COUNT(a.pt_id) AS Patient_Count,
    SUM(CASE WHEN a.DAMA = 'Yes' THEN 1 ELSE 0 END) AS DAMA_Count,
    SUM(CASE WHEN a.DEAD = 'Yes' THEN 1 ELSE 0 END) AS Death_Count,
	ROUND(SUM(CASE WHEN a.DAMA = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.pt_id), 2) AS DAMA_Rate_Percentage,
    ROUND(SUM(CASE WHEN a.DEAD = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.pt_id), 2) AS Death_Rate_Percentage
FROM doctors d
JOIN admissions a ON d.DOCTOR_ID = a.DOCTOR_ID
GROUP BY d.SPECIALIZATION
ORDER BY Death_Rate_Percentage DESC
