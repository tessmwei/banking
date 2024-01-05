SELECT 
    (duration / 500) * 500 AS duration_group,
    COUNT(*) AS total_durations,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS durations_with_poutcome_success,
    CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS success_rate
FROM Banking
GROUP BY duration_group
ORDER BY success_rate DESC;
