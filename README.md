# banking
## Background
This project delves into customer behaviour analysis within banking institutions, aiming to decipher patterns crucial for strategic decisions and financial sustainability. Understanding customers isn't just about tailoring services; it's about fostering trust and loyalty. For banks, attracting deposits signifies stability and liquidity, enabling loan provisions. Conversely, customers seek trust, security, and potential returns when selecting a bank. This project sheds light on these dynamics, aiding banks in optimizing strategies for better customer engagement and long-term financial viability.

## The Dataset
[Source: Kaggle](https://www.kaggle.com/datasets/thedevastator/bank-term-deposit-predictions/data)

The "Direct Marketing Campaigns for Bank Term Deposits" dataset encapsulates critical insights derived from direct marketing initiatives carried out by a Portuguese banking institution. Centred on phone-call campaigns, the primary aim was to gauge customers' interest in term deposits. This dataset encompasses multifaceted attributes:
- Age: The age of the customer.
- Job: The occupation of the customer.
- Marital Status: The marital status of the customer.
- Education: The education level of the customer.
- Default: Whether or not the customer has credit in default.
- Balance: The balance of the customer's account.
- Housing Loan: Whether or not the customer has a housing loan.
- Contact Communication Type: The method used to contact the customer (e.g., telephone, cellular).
- Day: The day of the month when the last contact with the customers was made.
- Duration: The duration (in seconds) of the last contact with customers during a campaign.
- Campaign Contacts Count: Number of contacts performed during this campaign for each customer
- pdays : number of days passed since previously contacted from the previous campaign
- poutcome : outcome from previous marketing campaign

The project leveraged the dataset's diverse attributes, enabling predictive modelling to forecast subscription likelihoods, customer segmentation for tailored strategies, and insights into optimizing future marketing endeavours through campaign analysis.

## Project Objectives:
| Objective  | Task |
| ------------- | ------------- |
| **1. Dataset Conversion and Utilization:**  | Convert the raw Parquet dataset into a CSV format and leverage SQL for exploration and utilization of the dataset's diverse attributes.
| **2. Customer Segmentation:**  | Identify distinct customer segments with varying propensities for term deposit subscriptions. This segmentation enabled tailored marketing strategies, enhancing campaign effectiveness.  |
| **3. Predictive Modeling and Forecasting:**  | Identify distinct customers with a high likelihood of subscription to term deposits.  |
| **4. Campaign Optimization Insights:**  | Identification of the most successful strategies in driving term deposit subscriptions, empowering banks to refine and enhance their future marketing campaigns.  |
| **5. Tableau Dashboard Presentation:**  | Employ Tableau dashboards as a visualization tool to present intricate customer segmentation data. |

## Analysis #1: Customer Segmentation
Customer demographics provide banks with a comprehensive overview of their customer base. By identifying distinct segments with varied tendencies towards term deposit subscriptions, the project aimed to equip banks with invaluable insights.

The segmentation analysis revealed diverse customer profiles, enabling the identification of segments with different propensities to subscribe to term deposits. Understanding these variations empowered banks to tailor marketing campaigns and strategies specific to each segment's preferences and behaviours. This personalized approach enhances campaign effectiveness by resonating more effectively with each customer segment, thereby increasing the likelihood of successful term deposit subscriptions.

### Marital Status Breakdown
```SQL
SELECT marital, COUNT(marital) AS total_customers
FROM Banking
GROUP BY marital;
```
The analysis of customer demographics based on marital status showcased a substantial presence of married individuals comprising the largest customer segment, accounting for 65.87% of the total customers. Singles formed a significant but relatively smaller segment at 30.98%, while the divorced category comprised 12.59% of the total customer base.

|marital|total_customers|
|-------|---------------|
|divorced|5207|
|married|27214|
|single|12790|

### Education Level Breakdown
```SQL
SELECT education, COUNT(education) AS total_customers
FROM Banking
GROUP BY education
ORDER BY total_customers DESC;
```
The analysis of education levels among customers highlights that the largest segment, constituting 56.18% of the dataset, holds secondary education. Following closely, individuals with tertiary education account for 32.19%, signifying another substantial portion. A smaller yet noteworthy group comprises customers with primary education, representing 16.57%. Additionally, a subset categorized as 'unknown' education, comprising 4.49% of the total customers, suggests potential data gaps or unrecorded education information within the dataset.
|education|total_customers|
|---------|---------------|
|secondary|23202|
|tertiary|13301|
|primary|6851|
|unknown|1857|

### Previous Campaign Success Rates by Age Group 
```SQL
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
    CONCAT(CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) *100,"%") AS success_rate
FROM Banking
GROUP BY age_group
ORDER BY MIN(age);
```
This breakdown by age groups, particularly the higher success rate among customers aged 65 and above at 16.25%, aligns with the notion that retired individuals, constituting a significant portion of this age bracket, often possess more substantial savings, fewer financial liabilities, and a greater inclination toward making deposits. This observation suggests a correlation between retirement status and a higher propensity to engage positively with term deposit subscriptions, highlighting the potential impact of financial stability and life stage on subscription behaviour. Conversely, younger age brackets, such as the 25-34 and 35-44 groups, show lower success rates at 3.28% and 2.71%, respectively.
|age_group|total_customers|success_customers|success_rate|
|---------|---------------|-----------------|------------|
|18-24|809|60|7.41656365883807%|
|25-34|14204|466|3.28076598141369%|
|35-44|14534|394|2.71088482179717%|
|45-54|9958|249|2.5005021088572%|
|55-65|4955|220|4.43995963673058%|
|65+|751|122|16.2450066577896%|

### Previous Campaign Success Rates by Education Level
```SQL
SELECT 
    job,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS success_customers,
    CONCAT(CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) *100, "%") AS success_rate
FROM Banking
GROUP BY job
ORDER BY success_rate DESC;
```
The breakdown by job categories reveals  insights into the success rates of term deposit subscriptions among various professions. Notably, students exhibit the highest success rate at 9.28%, possibly reflecting their limited financial obligations and receptiveness to savings. Surprisingly, retired individuals, often presumed to possess substantial savings, showcase a success rate of 7.69%, slightly lower than students. This discrepancy might be attributed to varying financial preferences among retirees or their diverse financial circumstances. Conversely, blue-collar workers exhibit the lowest success rate at 1.52%, potentially indicating different financial priorities or limited flexibility in allocating funds towards term deposits. These disparities among professions underscore the influence of job roles and financial standing on subscription behaviour, signalling the need for nuanced, job-specific marketing approaches to optimize subscription outcomes.
|job|total_customers|success_customers|success_rate|
|---|---------------|-----------------|------------|
|student|938|87|9.27505330490405%|
|retired|2264|174|7.68551236749117%|
|unemployed|1303|64|4.91174213353799%|
|management|9458|387|4.09177415944174%|
|admin.|5171|204|3.94507832140785%|
|unknown|288|11|3.81944444444444%|
|self-employed|1579|55|3.48321722609246%|
|technician|7597|245|3.22495721995525%|
|housemaid|1240|29|2.33870967741935%|
|services|4154|85|2.04622051035147%|
|blue-collar|9732|148|1.52075626798192%|
|entrepreneur|1487|22|1.47948890383322%|

### Housing Loan by Age
```SQL
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
```
In assessing the relationship between age demographics and housing loan ownership. Among younger age brackets, such as 18-24 and 25-34, more individuals have housing loans compared to those without, indicating a higher inclination toward home ownership or property investments. However, this trend shifts as age increases, notably among those aged 55 and above. In these older demographics, the number of individuals without housing loans surpasses those with loans, potentially signifying mortgage repayments being completed or a decrease in new property acquisitions. Interestingly, among individuals aged 65 and above, the disparity between housing loan holders and non-holders widens significantly, with only 21 individuals having housing loans compared to 730 without. This observation suggests a more stabilized housing status among retirees, possibly indicating mortgage completions and a higher percentage of property ownership.
|age_group|housing_loan_yes|housing_loan_no|
|---------|----------------|---------------|
|18-24|412|397|
|25-34|8719|5485|
|35-44|9180|5354|
|45-54|5061|4897|
|55-65|1737|3218|
|65+|21|730|

### Bank Balances Across Client-base
```SQL
SELECT 
    ROUND(AVG(balance), 2) AS average_balance,
    ROUND((MAX(balance) + MIN(balance)) / 2.0, 2) AS median_balance,
    ROUND(SUM((balance - (SELECT AVG(balance) FROM Banking)) * (balance - (SELECT AVG(balance) FROM Banking))) / COUNT(balance), 2) AS variance,
    ROUND(SQRT(SUM((balance - (SELECT AVG(balance) FROM Banking)) * (balance - (SELECT AVG(balance) FROM Banking))) / COUNT(balance)), 2) AS std_dev_balance,
    ROUND(MIN(balance), 2) AS min_balance,
    ROUND(MAX(balance), 2) AS max_balance
FROM Banking;
```
The bank balances analysis unveils a diverse spectrum of financial standings among clients. The average balance of 1362.27 reveals a median balance significantly higher at 47054.0, indicating the presence of outliers or a skewed distribution towards higher balances. The considerable variance of 9270393.9 and a standard deviation of 3044.73 further emphasize the wide dispersion of balances, signifying diverse financial profiles within the client base. The minimum balance recorded at -8019.0 might suggest overdrafts or exceptional cases, while the maximum balance of 102127.0 highlights substantial financial reserves within the clientele. This wide range underscores the need for personalized financial services to accommodate the varied financial needs and capacities of the client base.
|average_balance|median_balance|variance|std_dev_balance|min_balance|max_balance|
|---------------|--------------|--------|---------------|-----------|-----------|
|1362.27|47054.0|9270393.9|3044.73|-8019.0|102127.0|

## Analysis #2: Predictive Modelling and Forecasting

```SQL
SELECT *
FROM Banking
WHERE 
    (Age > 65 OR Job IN ('student', 'retired','management')) 
    AND Balance > 5000 
    AND "default"  = 'no' 
    AND pdays > 30;
```
The methodology employed primarily ceners on customer segmentation and the analysis of previous campaign success rates. Utilizing a set of predefined metrics, including age, job roles (such as 'student,' 'retired,' and 'management'), balance exceeding 5000, absence of loan defaults ('default' = 'no'), and a minimum of 30 days since the last contact ('pdays' > 30), the code aimed to generate a targeted list of clients highly likely to positively respond to the next campaign. The segmentation criteria, focusing on specific age brackets and job roles associated with potentially favourable responses, aimed to identify a subset of clients likely to express interest in term deposits. The inclusion of a balance threshold and absence of loan defaults further refined this list, targeting financially stable clients with a higher propensity for term deposit subscriptions.

The resultant dataset returned 283 rows, presenting a prioritized contact list for the next campaign, emphasizing clients with a high likelihood of responding positively. This targeted approach aims to optimize campaign success by focusing efforts on clients deemed more receptive based on their financial stability, age, occupation, and previous interaction patterns.
_Example of the first 10 rows:_
|ID|age|job|marital|education|default|balance|housing|loan|contact|day|month|duration|campaign|pdays|previous|poutcome|y|
|-------|---|---|-------|---------|-------|-------|-------|----|-------|---|-----|--------|--------|-----|--------|--------|-|
|24189|44|management|married|tertiary|no|6203|yes|yes|cellular|17|nov|58|1|188|1|failure|no|
|24331|36|management|married|tertiary|no|5057|yes|no|cellular|17|nov|70|1|166|10|failure|no|
|24346|48|management|single|tertiary|no|8106|no|no|unknown|17|nov|125|1|111|3|failure|no|
|24359|52|retired|married|secondary|no|5423|no|yes|cellular|17|nov|93|1|115|1|failure|no|
|24364|58|retired|married|secondary|no|8332|no|no|unknown|17|nov|164|2|96|4|failure|no|
|24618|38|management|single|tertiary|no|11971|yes|no|unknown|17|nov|609|2|101|3|failure|no|
|24801|58|management|married|tertiary|no|9339|yes|no|telephone|18|nov|52|3|172|3|other|no|
|24844|35|management|single|secondary|no|5260|yes|no|cellular|18|nov|59|1|182|2|failure|no|
|24987|39|management|divorced|tertiary|no|5009|yes|no|cellular|18|nov|255|1|126|2|failure|no|
|25068|34|management|divorced|tertiary|no|5754|yes|no|cellular|18|nov|32|1|181|1|failure|no|

## Analysis #3: Campaign Optimization Insights
In optimizing marketing campaigns, an analysis was conducted to dive into various factors' effectiveness in driving term deposit subscriptions. This  encompassed communication types, contact frequency, interaction durations, and previous campaign outcomes. Analyzing the impact of these variables identified the most successful strategies. Using this information, upcoming campaigns can be adjusted to focus on tactics that have proven to be more effective in getting people to subscribe. This ongoing process is aimed at improving how well campaigns work overall, increasing the number of subscriptions and the success of the campaigns for the institution.

### Number of Campaign Contacts Performed
```SQL
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
```
The breakdown of campaign groups based on the number of contacts made showcases varying success rates across different contact volumes. Notably, campaigns with fewer than 5 contacts exhibit the highest success rate at 3.68%, indicating a higher likelihood of subscription from these shorter campaigns. Conversely, as the number of contacts increases, success rates notably decline. Campaigns with 5-9 contacts display a success rate of 1.52%, and those with 10-14 contacts drop further to 0.12%. Intriguingly, campaigns with 30+ contacts and those within the range of 15-29 contacts recorded a 0% success rate, suggesting a diminishing return as the volume of contacts surpasses a certain threshold. These insights highlight the importance of targeted and concise campaign interactions, indicating that shorter, more focused campaigns tend to yield higher subscription rates compared to prolonged or excessive contact attempts.
|campaign_group|total_campaigns|success_campaigns|success_rate|
|--------------|---------------|-----------------|------------|
|<5|39092|1439|0.0368106006344009|
|5-9|4657|71|0.015245866437620785|
|10-14|848|1|0.0011792452830188679|
|30+|67|0|0.0|
|25-29|77|0|0.0|
|20-24|143|0|0.0|
|15-19|327|0|0.0|

### Duration of Contact

```SQL
SELECT 
    (duration / 500) * 500 AS duration_group,
    COUNT(*) AS total_durations,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS durations_with_poutcome_success,
    CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS success_rate
FROM Banking
GROUP BY duration_group
ORDER BY success_rate DESC;
```
The duration groups, categorized by the length of the last contact during campaigns, showcase varying success rates. Surprisingly, shorter durations of 500 seconds or less display the highest success rate at 4.59%, outperforming longer durations. Campaigns with durations of 1500, 1000, and even those with no specified duration (0 seconds) follow closely, hovering around 3-4% success rates. However, as the duration extends beyond 2000 seconds, success rates notably drop, with 0% success recorded for durations of 2500 seconds and above. These findings suggest that concise interactions, particularly those lasting 500 seconds or less, tend to yield higher subscription rates compared to more extended contact durations, signifying the importance of focused and efficient campaign communications.
|duration_group|total_durations|durations_with_poutcome_success|success_rate|
|--------------|---------------|-------------------------------|------------|
|500|4331|199|0.04594781805587624|
|1500|169|6|0.03550295857988166|
|1000|835|29|0.03473053892215569|
|0|39817|1276|0.032046613255644577|
|2000|36|1|0.027777777777777776|
|4500|1|0|0.0|
|3500|2|0|0.0|
|3000|11|0|0.0|
|2500|9|0|0.0|

### Method of Contact
```SQL
SELECT 
    contact,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS contacts_with_poutcome_success,
    CAST(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS success_rate
FROM Banking
GROUP BY contact;
```
Contact methods significantly impact subscription success rates. Cellular interactions demonstrate the highest success rate at 4.73%, surpassing telephone contacts at 3.92%. Surprisingly, 'unknown' modes record a notably lower success rate at 0.09%. This highlights the effectiveness of cellular communication in driving higher subscription rates compared to other contact methods.
|contact|total_contacts|contacts_with_poutcome_success|success_rate|
|-------|--------------|--------------------------|------------|
|cellular|29285|1385|0.047293836435035|
|telephone|2906|114|0.03922918100481762|
|unknown|13020|12|0.0009216589861751|





















