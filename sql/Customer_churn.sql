CREATE DATABASE churn_db;
USE churn_db;

-- COUNTING ROWS 
SELECT COUNT(*) AS Total_rows FROM customer_churn;

-- PREVIEW DATA 
SELECT * FROM customer_churn LIMIT 10;

-- CHECH NULL VALUES 
SELECT 
	SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END ) AS null_charges
FROM customer_churn;

-- DISTINCT VALUE CHECK 

SELECT DISTINCT Contract FROM customer_churn;
SELECT DISTINCT InternetService FROM customer_churn;
SELECT DISTINCT Churn FROM customer_churn;

-- OVERALL CHURN RATE 
SELECT
	ROUND(
		SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END ) *100.0 / COUNT(*),
        2
	)AS Churn_rate_percentage
FROM customer_churn;


-- CHURN BY CONTRACT TYPE 
SELECT 
	contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) AS churned_customer,
    ROUND(
		SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) *100.0 / COUNT(*) , 2 
	) AS churn_rate
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC ; 

-- REVENUE AT RISK 
SELECT 
	ROUND(SUM(MonthlyCharges),2) AS revenue_at_risk
FROM customer_churn
WHERE Churn ='Yes';

-- CHURN BY INTERNET SERVICE
SELECT 
	InternetService, 
    ROUND(
		SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2
	)AS churn_rate
FROM customer_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- CHURN KPI VIEW 
CREATE VIEW churn_kpi AS
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM customer_churn;

-- CONTRACT-LEVEL VIEW 
CREATE VIEW churn_by_contract AS
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM customer_churn
GROUP BY Contract;









