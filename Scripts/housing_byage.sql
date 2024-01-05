SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 65 THEN '55-65'
        ELSE '65+'
    END AS age_group,
    SUM(CASE WHEN housing = 'yes' THEN 1 ELSE 0 END) AS housing_loan_yes,
    SUM(CASE WHEN housing = 'no' THEN 1 ELSE 0 END) AS housing_loan_no
FROM Banking
GROUP BY age_group;
