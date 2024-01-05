SELECT 
    CASE 
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 65 THEN '55-65'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS success_customers,
    CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS success_rate
FROM Banking
GROUP BY age_group
ORDER BY MIN(age);
