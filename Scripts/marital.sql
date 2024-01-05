SELECT marital, COUNT(marital) AS total_customers
FROM Banking
GROUP BY marital;