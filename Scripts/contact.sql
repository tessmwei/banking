SELECT 
    contact,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS contacts_with_poutcome_yes,
    CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS success_rate
FROM Banking
GROUP BY contact;

