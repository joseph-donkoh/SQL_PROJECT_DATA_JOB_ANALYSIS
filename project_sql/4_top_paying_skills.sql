/*
Question: What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Analyst positions
-Focus on roles with specified salaries, regardless of location
-Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

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


/*💻 Data Science & Machine Learning Tools

Pandas ($151,821), NumPy ($143,513), Scikit-learn ($125,781), and Jupyter ($152,777) highlight that core Python data stack skills pay very well.

Databricks ($141,907) and Airflow ($126,103) show demand for data pipeline orchestration and cloud-based analytics.

PySpark’s lead reinforces the high value of distributed data handling at scale.

☁️ Cloud & Infrastructure

Kubernetes ($132,500) and GCP ($122,500) emphasize that cloud-native and container orchestration expertise are lucrative.

Linux ($136,508) remains a foundational skill — still among the best-paying due to its universality in server and cloud environments.

⚙️ Software Development & DevOps

GitLab ($154,500), Bitbucket ($189,155), and Jenkins ($125,436) show the DevOps CI/CD toolchain commands premium salaries.

Atlassian ($131,162) and Notion ($125,000) imply that collaboration and project management ecosystems also contribute to higher-paying roles.

🧠 Programming Languages

Swift ($153,750), Go/Golang ($145,000), and Scala ($124,903) all feature among top salaries — these languages are used in backend systems, data streaming, and mobile app development, which are high-impact, performance-critical areas.

📊 Database & BI Skills

PostgreSQL ($123,879) and MicroStrategy ($121,619) demonstrate solid pay for database management and business intelligence tools — though slightly below cutting-edge AI/ML stacks.

📈 Key Takeaways

Data engineering + ML automation = highest pay.

DevOps and CI/CD expertise drive high compensation, especially with Bitbucket, GitLab, and Jenkins.

Modern cloud and infrastructure skills (Kubernetes, GCP, Linux) remain vital.

Less common tools (Couchbase, DataRobot, Watson) offer niche premiums.

The average among these top skills exceeds $145K, showing how specialized expertise outpaces general data or analytics skills.
*/
/*[
  {
    "skills": "pyspark",
    "overall_avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "overall_avg_salary": "189155"
  },
  {
    "skills": "couchbase",
    "overall_avg_salary": "160515"
  },
  {
    "skills": "watson",
    "overall_avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "overall_avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "overall_avg_salary": "154500"
  },
  {
    "skills": "swift",
    "overall_avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "overall_avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "overall_avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "overall_avg_salary": "145000"
  },
  {
    "skills": "golang",
    "overall_avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "overall_avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "overall_avg_salary": "141907"
  },
  {
    "skills": "linux",
    "overall_avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "overall_avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "overall_avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "overall_avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "overall_avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "overall_avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "overall_avg_salary": "125436"
  },
  {
    "skills": "notion",
    "overall_avg_salary": "125000"
  },
  {
    "skills": "scala",
    "overall_avg_salary": "124903"
  },
  {
    "skills": "postgresql",
    "overall_avg_salary": "123879"
  },
  {
    "skills": "gcp",
    "overall_avg_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "overall_avg_salary": "121619"
  }
]
*/