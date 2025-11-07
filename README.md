# Introduction
Explore the data job market with an emphasis on data analyst positions.

This project investigates the highest paying jobs and the most sought-after skills, particularly in areas where significant demand aligns with substantial salaries in data analytics.

It includes SQL queries—check them out in [prject_sql folder](/project_sql/).

# Background
The idea for this project is to discover high-paying and in-demand skills in the Data Analytics job market in order to help job seekers better prepare for the skills needed for optimal jobs.

I used the data from Luke Barousse's SQL course on Youtube(https://www.lukebarousse.com/sql). It contains variuos insights on job titles, salaries, locations, and essential skills. 

### The questions answered through SQL queries are the following:

1. What are the top-paying Data Analyst jobs/
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for Data Analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used

1. **SQL**: The language used for the analysis and queying the database to uncover valuable insgishts
2. **PostgreSQL**: The database mangement system for handling the data
3. **VS Code**: I connected it to the database and used it to execute the SQL queries
4. **Git and GitHub**: For version control, sharing my analysis and project tracking

# The Analysis Involved

This section investigates specific aspects of the data job market using SQL queries to uncover insights into top-paying roles, required skills, and optimal career paths. The analysis is structured around five distinct queries, each building upon the previous one to provide a comprehensive understanding.

### 1. Top Paying Data Analyst Jobs

Objective: Identify the highest-paying data analyst roles that are available remotely, focusing on job postings that include salary data. This query aims to offer insights into target roles for job seekers.

***Methodology***:

Selected job_id, job_title_short, job_location, job_schedule_type, salary_year_average, and job_posted_date from the job_postings_fact table.

Filtered for job_title_short equal to 'Data Analyst' and job_location as 'Anywhere' (for remote positions).

Ensured salary_year_average was not null to include only postings with specified salaries.

Ordered the results by salary_year_average in descending order and limited to the top 10.

A LEFT JOIN with the company_dim table was used to include company_name for better context.

``` sql
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
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL 
ORDER BY
    salary_year_avg DESC
LIMIT (10);
```

***Findings***: 
- Data analytics remains one of the most lucrative and stable fields.

- Leadership and specialization (e.g., Principal or Director roles) dramatically boost pay.

- Remote work has become standard for high-paying analytics positions.

- The average salary (excluding Mantys) is around $235K, still very strong compared to general tech roles.
### 2. Top Paying Job Skills

Objective: Determine the essential skills required for the top-paying data analyst roles identified in the first query. This helps job seekers focus on acquiring skills that command high salaries.

***Methodology***:

Built upon the previous "Top Paying Data Analyst Jobs" query by converting it into a Common Table Expression (CTE) named top_paying_jobs_result_set.

Performed INNER JOIN operations with skills_job_dim and skills_dim tables to link job postings with their associated skills.

Selected all columns from the CTE and the skill_name from the skills_dim table.

Ordered the results by salary_year_average in descending order.

```sql
WITH top_paying_jobs AS (
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
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL 
    ORDER BY
        salary_year_avg DESC
    LIMIT (10)
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

***Findings***:
- SQL and Python are the most dominant skills strong indicators of data-related job roles.

- Tableau ranks high, showing strong demand for data visualization expertise.

- There’s a mix of data engineering (Snowflake, Azure, AWS) and collaboration tools (Jira, Confluence, GitLab), suggesting many roles involve both technical and project coordination skills.

- Excel remains relevant, even in technical jobs.


### 3. Most In-Demand Skills

Objective: Identify the most frequently demanded skills across all (or remote, as an alternative) data analyst job postings. This query provides a broader view of skill popularity beyond just high-paying roles.

**Methodology**:

Joined job_postings_fact, skills_job_dim, and skills_dim tables.

Grouped the results by skill_name and counted the occurrences of each skill to determine demand.

Filtered for job_title_short equal to 'Data Analyst' and optionally for job_work_from_home as 'True'.

Ordered the skills by their demand count in descending order.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

**Findings**: SQL, Excel, Python, Tableau, and Power BI consistently appeared at the top, indicating their high demand in the data analyst job market, with similar trends observed for both all jobs and remote-only positions.

### 4. Top Skills Based on Salary

Objective: Analyze the average salary associated with various skills, specifically for data analyst positions, to understand which skills directly correlate with higher earnings.

**Methodology**:

Similar to Query 3, involved joining job_postings_fact, skills_job_dim, and skills_dim tables.

Grouped by skill_name and calculated the AVG(salary_year_average), rounding the result.

Filtered for 'Data Analyst' roles and excluded null salary_year_average values.

Initially, the query was run without location constraints, then adapted to specifically target remote jobs.

Ordered the results by the calculated average salary in descending order.

```sql
SELECT  
    skills,
    ROUND(AVG(salary_year_avg), 0) AS overall_avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    overall_avg_salary DESC
LIMIT 25;
```

**Findings**: Data engineering + ML automation = highest pay.

DevOps and CI/CD expertise drive high compensation, especially with Bitbucket, GitLab, and Jenkins.

Modern cloud and infrastructure skills (Kubernetes, GCP, Linux) remain vital.

Less common tools (Couchbase, DataRobot, Watson) offer niche premiums.

The average among these top skills exceeds $145K, showing how specialized expertise outpaces general data or analytics skills.


### 5. Most Optimal Skills

Objective: Combine insights from skill demand and average salary to identify the most optimal skills for data analysts—those that are both highly demanded and highly compensated.

**Methodology**:

Utilized two CTEs: one for skills_demand (from Query 3's logic) and another for average_salary (from Query 4's logic).

Joined these two CTEs on skill_id to merge demand and salary data for each skill.

Selected skill_id, skill_name, demand_count, and average_salary.

Ordered the final results first by average_salary in descending order, then by demand_count in descending order.

A WHERE clause was added to filter for demand_count greater than an arbitrary threshold (e.g., 10) to ensure relevance, demonstrating the use of a HAVING clause for aggregations.

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id, 
        ROUND(AVG(salary_year_avg), 0) AS overall_avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
    )

    SELECT
        skills_demand.skill_id,
        skills_demand.skills,
        demand_count,
        overall_avg_salary
    FROM
        skills_demand
    INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
    
    WHERE
        demand_count > 10
    ORDER BY
        overall_avg_salary DESC,
        demand_count DESC
        
    LIMIT 25;
```

**Findings**: This integrated analysis helped pinpoint skills that strike a balance between high market demand and high earning potential, guiding strategic skill development for data analysts.

# What I learned
- **Personal Growth and Skill Reinforcement**: The project helped me in deepening the practical application of SQL knowledge. It  solidified my understanding of SQL concepts, moving beyond mere memorization to actual implementation. 
- **Addressing Challenges and Problem-Solving**: The complexity of some of the queries were challenging at the beginning. But I was able to deal with them by constantly practicing the right queries in order to overcome the hurdles.
- **Insights into Data Analytics Workflow**: I engaged in a broader data analytics process, including data extraction, transformation, analysis, and visualization, integrating various tools like SQL, VS Code, Git, GitHub.
- **Understanding Real-World Applications**:  Reflecting on the insights gained from this analysis, such as identifying optimal skills or understanding salary trends, this project has a practical application for the real world. It will help job seekers know which skills to learn or improve upon in order to attain optimal employment opportunities. 
# Conclusion
Engaging in this SQL project, which is part of Luke Barousse’s Data Analyst Portfolio Project, proved to be a transformative experience. It provided me with the opportunity to implement practical SQL techniques, including filtering, aggregation, joins, and CTEs, to extract valuable insights from job market data.

During the analysis, I identified that certain skills, such as SQL, Python, and Excel, are in high demand, whereas others like PySpark, Databricks, and GitLab are associated with the highest salaries. This underscored the importance of balancing the mastery of fundamental analytics tools with the exploration of specialized technologies that can enhance one’s marketability.

In summary, this project significantly bolstered my confidence in crafting complex SQL queries, as well as in cleaning and transforming data, and effectively presenting my findings. It also enriched my comprehension of how data can be leveraged to investigate career trends and facilitate evidence-based decision-making.