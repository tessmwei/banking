SELECT 
    CASE 
        WHEN campaign < 5 THEN '<5'
        WHEN campaign BETWEEN 5 AND 9 THEN '5-9'
        WHEN campaign BETWEEN 10 AND 14 THEN '10-14'
        WHEN campaign BETWEEN 15 AND 19 THEN '15-19'
        WHEN campaign BETWEEN 20 AND 24 THEN '20-24'
        WHEN campaign BETWEEN 25 AND 29 THEN '25-29'
        ELSE '30+'
    END AS campaign_group,
    COUNT(*) AS total_campaigns,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS success_campaigns,
    CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS success_rate
FROM Banking
GROUP BY campaign_group
ORDER BY success_rate DESC;
