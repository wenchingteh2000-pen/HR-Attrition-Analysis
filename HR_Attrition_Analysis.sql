-- How many total employees are there?
SELECT COUNT(DISTINCT EmployeeNumber) AS total_employee
FROM WA_Fn_UseC wfuc ;

SELECT Attrition, COUNT(*) AS total_employee
FROM WA_Fn_UseC wfuc 
GROUP BY Attrition;

-- What is the overall attrition rate
SELECT 
	COUNT(*) AS total_employee, 
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition, 
	1.0 * SUM(CASE WHEN Attrition = "Yes" THEN 1 ELSE 0 END) / COUNT(*) AS attrition_rate_percentage
FROM WA_Fn_UseC wfuc ;

-- What are the minimum, maximum and average age of employees?
SELECT MIN(Age) AS min_age, MAX(Age) AS max_age, ROUND(AVG(Age),2) AS average_age
FROM WA_Fn_UseC wfuc ;

-- What is the average monthly income of employees?
SELECT ROUND(AVG(MonthlyIncome),2) AS average_monthly_income
FROM WA_Fn_UseC wfuc ;

-- What is the attrition rate by department?
SELECT 
	Department, 
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition, 
	COUNT(*) AS total_employee, 
	1.0*SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS attrition_rate_percentage
FROM WA_Fn_UseC wfuc
GROUP BY wfuc.Department ;

-- What is the attrition rate by job role
SELECT
	JobRole,
	COUNT(*) AS total_attrition,
	1.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS attrition_rate_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY wfuc.JobRole ;

-- Is attrition higher among employees with shorter tenure?
SELECT
	CASE 
		WHEN YearsAtCompany <= 1 THEN '0-1 Year'
		WHEN YearsAtCompany <= 3 THEN '2-3 Years'
		WHEN YearsAtCompany <= 5 THEN '4-5 Years'
		WHEN YearsAtCompany <= 10 THEN '6-10 Years'
		ELSE '10+ Years'
	END AS Tenure_group,
	COUNT(*) AS total_employee,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
	1.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS attrition_rate_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY Tenure_group 
ORDER BY attrition_rate_percentage DESC;
	
-- Is there a relationship between job satisfaction and attrition?
SELECT 
	JobSatisfaction, 
	ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS total_attrition_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY JobSatisfaction;

-- Which education field has the highest attrition?
SELECT 
	EducationField,
	COUNT(*) AS total_employee,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
	ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS total_attrition_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY EducationField 
ORDER BY total_attrition_percentage DESC;

-- How many employees are there in each department?
SELECT Department, COUNT(*) AS total_employees
FROM WA_Fn_UseC wfuc 
GROUP BY wfuc.Department ;

-- What is the average income per department?
SELECT Department, COUNT(*) AS total_employees, ROUND(AVG(MonthlyIncome),2) AS average_income
FROM WA_Fn_UseC wfuc 
GROUP BY Department;

-- Which job roles have the highest number of employees?
SELECT JobRole, COUNT(*) AS total_employees
FROM WA_Fn_UseC wfuc 
GROUP BY wfuc.JobRole 
ORDER BY total_employees DESC;

-- What is the average performance rating by job role?
SELECT JobRole, ROUND(AVG(PerformanceRating),2) AS avg_performance_rating
FROM WA_Fn_UseC wfuc 
GROUP BY wfuc.JobRole ;

-- What is the average monthly income by job level?
SELECT JobLevel, ROUND(AVG(MonthlyIncome),2) AS avg_monthly_income
FROM WA_Fn_UseC wfuc 
GROUP BY wfuc.JobLevel ;

-- What is the income distribution by department?
SELECT 
	Department, 
	COUNT(*) AS total_employees,
	MIN(MonthlyIncome) AS min_monthly_income,
	MAX(MonthlyIncome) AS max_monthly_income,
	ROUND(AVG(MonthlyIncome),2) AS avg_monthly_income
FROM WA_Fn_UseC wfuc 
GROUP BY wfuc.Department 
ORDER BY avg_monthly_income DESC;

-- Does overtime affect attrition?
SELECT 
	Overtime, 
	COUNT(*) AS total_employee,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
	1.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS total_attrition_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY Overtime;

-- Compare average income of employees who left vs who stayed.
SELECT 
	Attrition,
	COUNT(*) AS total_employees,
	ROUND(AVG(MonthlyIncome),2) AS avg_monthly_income
FROM WA_Fn_UseC wfuc 
GROUP BY Attrition;

-- What is the distribution of job satisfaction scores?
SELECT 
	JobSatisfaction,
	COUNT(*) AS total_employee
FROM WA_Fn_UseC wfuc 
GROUP BY JobSatisfaction  ;

-- What is the average job involvement score by department?
SELECT Department, ROUND(AVG(JobInvolvement),2) AS avg_job_involvement
FROM WA_Fn_UseC wfuc 
GROUP BY Department;

-- How does environment satisfaction vary by job role?
SELECT JobRole, ROUND(AVG(EnvironmentSatisfaction),2) AS avg_environment_satisfaction
FROM WA_Fn_UseC wfuc 
GROUP BY JobRole
ORDER BY avg_environment_satisfaction DESC;

-- How does environment satisfaction vary by job role? (2)
SELECT
	JobRole,
	COUNT(CASE WHEN EnvironmentSatisfaction = 4 THEN 1 END) AS high_satisfaction_count,
	COUNT(*) AS total_employees,
	ROUND(100.0 * COUNT(CASE WHEN EnvironmentSatisfaction = 4 THEN 1 END) / COUNT(*),2) AS high_satisfaction_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY JobRole;

SELECT JobRole, JobSatisfaction, EmployeeNumber
FROM WA_Fn_UseC wfuc 
GROUP BY JobRole, JobSatisfaction ;

-- Is there a link between work-life balance and attrition?
SELECT 
	WorkLifeBalance,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
	ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS total_attrition_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY WorkLifeBalance;

-- 	What is the average years at company by department?
SELECT Department, ROUND(AVG(YearsAtCompany),2) AS avg_years
FROM WA_Fn_UseC wfuc 
GROUP BY Department ;

-- How many employees were promoted (YearsSinceLastPromotion)?
SELECT 
	YearsSinceLastPromotion, 
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
	ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS total_attrition_percentage
FROM WA_Fn_UseC wfuc 
GROUP By YearsSinceLastPromotion;

-- What is the average years in current role by job level?
SELECT JobLevel, ROUND(AVG(YearsInCurrentRole),2) AS avg_years_in_current_role
FROM WA_Fn_UseC wfuc 
GROUP BY JobLevel;

-- Do employees with more training (TrainingTimesLastYear) have lower attrition?
SELECT 
	TrainingTimesLastYear,
	COUNT(*),
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
	ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS total_attrition_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY TrainingTimesLastYear ;

-- What is the gender distribution of employees?
SELECT Gender, COUNT(*) AS total_employees, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attriton
FROM WA_Fn_UseC wfuc 
GROUP BY Gender;

SELECT EmployeeNumber, Gender, Attrition
FROM WA_Fn_UseC wfuc ;

-- What is the age distribution?
SELECT 
	CASE 
		WHEN Age <= 20 THEN '18-21 Years Old'
		WHEN Age <= 30 THEN '21-30 Years Old'
		WHEN Age <= 40 THEN '31-40 Years Old'
		WHEN Age <= 50 THEN '41-50 Years Old'
		ELSE '51-60 Years Old'
	END AS Age_range,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attriton,
	1.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS total_attrition_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY Age_range ;

-- What is the attrition rate by marital status?
SELECT 
	MaritalStatus,
	ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM WA_Fn_UseC wfuc 
GROUP BY MaritalStatus ;

-- What is the education level breakdown?
SELECT 
	CASE
		WHEN Education = 1 THEN 'Below College'
		WHEN Education = 2 THEN 'College'
		WHEN Education = 3 THEN 'Bachelor'
		WHEN Education = 4 THEN 'Master'
		WHEN Education = 5 THEN 'Doctor'
	END AS Education_level,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition
FROM WA_Fn_UseC wfuc 
GROUP BY Education_level
ORDER BY Education;

-- Who are the top 10 highest-paid employees?
SELECT EmployeeNumber, MonthlyIncome
FROM WA_Fn_UseC wfuc 
ORDER BY MonthlyIncome DESC
LIMIT 10;

-- What is the average distance from home for employees who left?
SELECT ROUND(AVG(DistanceFromHome),2) AS avg_distance_from_home
FROM WA_Fn_UseC wfuc 
WHERE Attrition = 'Yes';

-- Is there a pattern between business travel frequency and attrition?
SELECT
	BusinessTravel,
	ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS total_attrition_percentage
FROM WA_Fn_UseC wfuc 
GROUP BY BusinessTravel
ORDER BY total_attrition_percentage DESC;