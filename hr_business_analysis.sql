USE human_resources;

SELECT * FROM hr;

SELECT gender, COUNT(*) AS gdr_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;

SELECT race, COUNT(*) AS no_race
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY race
ORDER BY 2 DESC;

SELECT 
CASE
  WHEN age BETWEEN 18 AND 24 THEN '18-24'
  WHEN age BETWEEN 25 AND 34 THEN '25-34'
  WHEN age BETWEEN 35 AND 44 THEN '35-44'
  WHEN age BETWEEN 45 AND 54 THEN '45-54'
  ELSE '65+'
END AS age_group,
COUNT(*) AS age_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

SELECT location, COUNT(*) AS lctn_cnt
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY location;

SELECT ROUND(AVG(length_of_stay)) AS avg_length_of_stay
FROM 
(SELECT termdate, YEAR(termdate) -  YEAR(hire_date) AS length_of_stay
FROM hr
WHERE age >= 18 AND termdate IS NOT NULL) sub;

SELECT  department, jobtitle, gender, COUNT(*) AS age_dpt_jbtitle
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY department, jobtitle, gender
ORDER BY department;

SELECT jobtitle, COUNT(*) AS Job_title_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle;

SELECT department,
 total_count,
 terminated_count,
 terminated_count/total_count AS termination_rate
 FROM (
   SELECT department,
   COUNT(*) AS total_count,
   SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
   FROM hr
   WHERE age >= 18
   GROUP BY department) AS t
   ORDER BY termination_rate DESC;
   
SELECT location_city, location_state, COUNT(*) AS empl_ltn
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY location_city, location_state
ORDER BY 3 DESC;


SELECT YEAR(hire_date) AS years, 
       COUNT(*) AS total_hires, 
	   COUNT(termdate) AS terminations,
       COUNT(*) - COUNT(termdate) AS net_change
FROM hr
WHERE age >= 18
GROUP BY 1
ORDER BY 1;