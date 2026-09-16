# Introduction
Dive into the data job market! Focusing on Data Analysis roles, this projectexplores top-paying jobs, in-demand skills and where high demand meets high salary in data analytics.

SQL Queries? Check them out here: [project_sql folder] (/project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pin-point top payingband in-demand skills, streamlinging others work to find optimal jobs.

Data hails from my [sql course] (https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locationand essential skills.

### The question I wanted to answer through my sql queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analyst?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I used
For my deep dive into the data analyst job market, I harnessed the power of key tools:
- **SQl:** The backbone of my analyst, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The choosen database management system, ideal for handling the job postings data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git and GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The analysis
Each query for this project aimed at investigating specific aspects for the data analyst job market.
Here's how I approached the question:

### 1.Top Paying Data Analyst Jobs
To identify the highest-paying roles,I filtered data analyst positions by average year salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short= 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
Here's a breakdown of the top data analyst jobs in 2023:
- **Wide salary range:** Top 10 paying data analyst roles span from $184,000 to $650,000 indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job tiltles,from Data Analyst to Director of Analytics, reflecting varied roles and specializations within Data Analyticts. 
### 2. Skills for top paying jobs
To understand what skills are required for the top-paying jobs, I joined the job-postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (

	SELECT
		job_id,
		job_title,
		salary_year_avg,
    name AS company_name
	FROM
		job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
	WHERE
		job_title_short = 'Data Analyst'
		AND job_location = 'Anywhere'
		AND salary_year_avg IS NOT NULL
	ORDER BY
		salary_year_avg DESC
	LIMIT 10
)
SELECT 
	top_Paying_jobs.*,
	skills
FROM top_Paying_jobs
	INNER JOIN skills_job_dim  ON top_paying_jobs.job_id = skills_job_dim.job_id
	INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    ORDER BY
	    salary_year_avg DESC
```
Here's a breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6. Other skills like **R, Snowflake, Pandas,** and **Excel** shaow varying degrees of demand.

### 3. In-Demand Skills for Data Analysts.
This query helped identify the skills modt frequently requested in job postings, directing focus to areas with high demand. 

```sql
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
```
Here's a breakdown of the most demanded skills for data analyst in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation. 
- **Programming** and **Visualization Tools** like **Python, Tableau and Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills | Demand Count |
| :--- | :--- |
| SQL | 7,291 |
| Excel | 4,611 |
| Python | 4,330 |
| Tableau | 3,745 |
| Power BI | 2,609 |

### 4. Skills Based on Salary
Exploring the average  salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
ORDER BY
    avg_salary DESC
LIMIT 25
```
Here's a breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies(Py Spark, Couchbase), machine learning tools(DataRobot, Jupyter) and Python libraries(Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modelling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge  in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between Data Analysis and Engineering, with a premium on skills that facilitate automation and effecient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based  analytics environments , suggesting that cloud proficiency significantly boosts earning potential in data analytics. 

| Skills | Avg Salary |
| :--- | :--- |
| PySpark | $208,172.25 |
| Bitbucket | $189,154.50 |
| Couchbase | $160,515.00 |
| Watson | $160,515.00 |
| DataRobot | $155,485.50 |
| GitLab | $154,500.00 |
| Swift | $153,750.00 |
| Jupyter | $152,776.50 |
| Pandas | $151,821.33 |
| Elasticsearch | $145,000.00 |
| Go | $145,000.00 |
| NumPy | $143,512.50 |
| Databricks | $141,906.60 |
| Linux | $136,507.50 |
| Kubernetes | $132,500.00 |
| Atlassian | $131,161.80 |
| Twilio | $127,000.00 |
| Airflow | $126,103.00 |
| scikit-learn | $125,781.25 |
| Jenkins | $125,436.33 |
| Notion | $125,000.00 |
| Scala | $124,903.00 |
| PostgreSQL | $123,878.75 |
| GCP | $122,500.00 |
| MicroStrategy | $121,619.25 |

### 5. Most Optimal skills to learn
Combining insights from demand and salary data , this query aimed to pinpoint skills that are both  in high demand and  have  high salaries,  offering  a stategic focus on skills development. 
```sql
WITH skills_demand AS (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
	INNER JOIN skills_job_dim  ON job_postings_fact.job_id = skills_job_dim.job_id
	INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
	job_title_short='Data Analyst' AND
 	job_location = 'Anywhere' AND
 	salary_year_avg IS NOT NULL
GROUP BY 
	skills_dim.skill_id


)

, avg_salary AS  (
SELECT
skills_job_dim.skill_id,
ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
	INNER JOIN skills_job_dim  ON job_postings_fact.job_id = skills_job_dim.job_id
	INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
	job_title_short='Data Analyst' AND
 	job_location = 'Anywhere' AND
 	salary_year_avg IS NOT NULL
GROUP BY 
	skills_job_dim.skill_id

)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
WHERE 
	demand_count > 10
ORDER BY
	demand_count DESC,
	avg_salary DESC
limit 25
```

| Skill ID | Skills | Demand Count | Avg Salary |
| :--- | :--- | :--- | :--- |
| 0 | SQL | 398 | $97,237 |
| 181 | Excel | 256 | $87,288 |
| 1 | Python | 236 | $101,397 |
| 182 | Tableau | 230 | $99,288 |
| 5 | R | 148 | $100,499 |
| 183 | Power BI | 110 | $97,431 |
| 7 | SAS | 63 | $98,902 |
| 186 | SAS | 63 | $98,902 |
| 196 | PowerPoint | 58 | $88,701 |
| 185 | Looker | 49 | $103,795 |
| 188 | Word | 48 | $82,576 |
| 80 | Snowflake | 37 | $112,948 |
| 79 | Oracle | 37 | $104,534 |
| 61 | SQL Server | 35 | $97,786 |
| 74 | Azure | 34 | $111,225 |
| 76 | AWS | 32 | $108,317 |
| 192 | Sheets | 32 | $86,088 |
| 215 | Flow | 28 | $97,200 |
| 8 | Go | 27 | $115,320 |
| 199 | SPSS | 24 | $92,170 |
| 22 | VBA | 24 | $88,783 |
| 97 | Hadoop | 22 | $113,193 |
| 233 | Jira | 20 | $104,918 |
| 9 | JavaScript | 20 | $97,587 |
| 195 | SharePoint | 18 | $81,634 |

Table of the most optimal skills for data analyst sorted by salary.

Here's a breakdown of the most optimal skills for Data Analyst in 2023:
- **High-Demand Programming Languages:** Python  and R stand out for their high demand with demand counts for 236 and 148  respectively.  Despite their high demand, their average salaries are around $100,499 for R, indicating that proficiency in these languages is highly  valued  but also widely available.
- **Cloud Tools and Technologies:**  Skills in  specialized technologies such as  Snowflake, Azure, AWS,  and BigQuery show significant demand with relatively  high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Inteligence & Visualization Tools:**  Tableau and Looker , with demand counts of 230 and 49 resectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data. 
- **Database Technologies:** The demand for skills in traditional and NoSQL database(Oracle, SQLServer, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects  the enduring need for data storage, retreval, and management expertise. 
# What I learnt
Throughout this adventure, I've turbochanged my SQL, toolkit with some serious firepower:
- **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH  clauses for ninja-level temp table maneuvers.
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **Analytical Thinking:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insughtful SQL queries. 

 
# Conclusions 

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs:** The highest paying jobs for data analyst that allow for remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills forTop-paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most-in demand skills:**  SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with higher salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest  average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanceed my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring  data analyst can beter position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continous learning and adaptation to emerging trends in the field of data analytics.