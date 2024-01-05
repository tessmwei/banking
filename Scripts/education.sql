SELECT education, COUNT(education) AS total_customers
FROM Banking
GROUP BY marital;