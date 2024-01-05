SELECT 
    ROUND(AVG(balance), 2) AS average_balance,
    ROUND((MAX(balance) + MIN(balance)) / 2.0, 2) AS median_balance,
    ROUND(SUM((balance - (SELECT AVG(balance) FROM Banking)) * (balance - (SELECT AVG(balance) FROM Banking))) / COUNT(balance), 2) AS variance,
    ROUND(SQRT(SUM((balance - (SELECT AVG(balance) FROM Banking)) * (balance - (SELECT AVG(balance) FROM Banking))) / COUNT(balance)), 2) AS std_dev_balance,
    ROUND(MIN(balance), 2) AS min_balance,
    ROUND(MAX(balance), 2) AS max_balance
FROM Banking;
