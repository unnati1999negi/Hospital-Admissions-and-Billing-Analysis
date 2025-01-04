-- Hospital Admission and Billing Analysis

-- Database creation
CREATE DATABASE HealthcareDB;
USE HealthcareDB;

-- Table creation
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    medical_condition VARCHAR(100),
    date_of_admission DATE,
    doctor VARCHAR(100),
    hospital VARCHAR(100),
    insurance_provider VARCHAR(100),
    billing_amount DECIMAL(12, 2),
    room_number INT,
    admission_type VARCHAR(50),
    discharge_date DATE,
    medication VARCHAR(100),
    test_results VARCHAR(50)
);

-- 1. List all patients
SELECT * FROM Patients;

-- 2. Find all female patients
SELECT name, age, medical_condition
FROM Patients
WHERE gender = 'Female';

-- 3. Count the number of patients by gender
SELECT gender, COUNT(*) AS total_patients
FROM Patients
GROUP BY gender;

-- 4. Find patients admitted after January 1, 2024
SELECT name, date_of_admission
FROM Patients
WHERE date_of_admission > '2024-01-01';

-- 5. Retrieve patients with billing over $20,000
SELECT name, billing_amount, medical_condition
FROM Patients
WHERE billing_amount > 20000;

-- 6. Total billing amount by hospital
SELECT hospital, SUM(billing_amount) AS total_billing
FROM Patients
GROUP BY hospital
ORDER BY total_billing DESC;

-- 7. Find the top 3 most common medical conditions
SELECT medical_condition, COUNT(*) AS occurrence
FROM Patients
GROUP BY medical_condition
ORDER BY occurrence DESC
LIMIT 3;

-- 8. List all patients who were readmitted (Emergency Admissions)
SELECT name, date_of_admission, discharge_date
FROM Patients
WHERE admission_type = 'Emergency' AND discharge_date > date_of_admission;

-- 9. Find average patient age by admission type
SELECT admission_type, AVG(age) AS average_age
FROM Patients
GROUP BY admission_type;

-- 10. Calculate total revenue collected by insurance provider
SELECT insurance_provider, SUM(billing_amount) AS total_revenue
FROM Patients
GROUP BY insurance_provider
ORDER BY total_revenue DESC;

-- 11. Find patients with the longest hospital stay
SELECT name, DATEDIFF(discharge_date, date_of_admission) AS days_stayed
FROM Patients
ORDER BY days_stayed DESC
LIMIT 5;

-- 12. Identify patients with abnormal test results admitted in the last 6 months
SELECT name, medical_condition, test_results, date_of_admission
FROM Patients
WHERE test_results = 'Abormal' 
AND date_of_admission >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 13. List doctors with the most patients
SELECT doctor, COUNT(*) AS patient_count
FROM Patients
GROUP BY doctor
ORDER BY patient_count DESC
LIMIT 3;

-- 14. Find total patients by hospital and admission type
SELECT hospital, admission_type, COUNT(*) AS total_patients
FROM Patients
GROUP BY hospital, admission_type
ORDER BY hospital;

-- 15. Get patients who spent more than the average billing amount
SELECT name, billing_amount
FROM Patients
WHERE billing_amount > (SELECT AVG(billing_amount) FROM Patients);

