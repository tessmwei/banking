SELECT job, count(job) AS numjob 
FROM Banking
WHERE y = 'yes'
GROUP BY job
ORDER BY numjob DESC 
LIMIT 10;
