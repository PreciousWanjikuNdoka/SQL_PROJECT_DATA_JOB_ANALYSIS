/* what are the most in demand skills for data analyst jobs?
-join job postingsto inner jointable similar to query 2
-identify the top 5 in-demand skills for Data Analyst roles that are available remotely
focus on all job postings
-why? Retrives the top 5 skillswith the highest demand in the job market,
providing insights into the skills that are most sought after by employers in the field of data analysis
*/  
SELECT
skills,
COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
	INNER JOIN skills_job_dim  ON job_postings_fact.job_id = skills_job_dim.job_id
	INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
	job_title_short='Data Analyst' AND
 	job_location = 'Anywhere'
GROUP BY 
	skills
ORDER BY
	 demand_count DESC
LIMIT 5