SELECT 
    job,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS success_customers,
    CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS success_rate
FROM Banking
GROUP BY job;