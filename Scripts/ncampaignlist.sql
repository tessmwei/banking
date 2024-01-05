SELECT *
FROM Banking
WHERE 
    (Age > 65 OR Job IN ('retired', 'management')) 
    AND Balance > 5000 
    AND "default"  = 'no' 
    AND pdays > 30;
