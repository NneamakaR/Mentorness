--  CORONA VIRUS ANALYSIS // BATCH NAME: MIP-DA-07

-- Skills used: Aggregate Functions, Coalesce Function, CTE's

-- Q1. Write a code to check NULL values

SELECT * FROM corona_virus_data
WHERE COALESCE(ï»¿Province, `Country/Region`, Latitude, Longitude, Date, Confirmed,Deaths) IS NULL;

-- Q2. If NULL values are present, update them with zeros for all columns. 

-- NULL value not present.

-- Q3. check total number of rows

SELECT count(*) AS 'total_number_of_rows'
FROM corona_virus_data;

-- Q4. Check what is start_date and end_date

SELECT min(Date) AS 'start_date', max(Date) AS 'end_date'
FROM corona_virus_data;

-- Q5. Number of month present in dataset

SELECT YEAR(Date) AS Year, COUNT(DISTINCT MONTH(Date)) AS num_months FROM corona_virus_data
GROUP BY YEAR(Date);

-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT YEAR(Date) AS year, MONTH(Date) AS month, 
AVG(Confirmed) AS Avg_confirmed, AVG(Deaths) AS Avg_deaths, AVG(Recovered) AS Avg_recovered
FROM corona_virus_data
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY year, month;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month
 -- frequent value for confirmed cases
 
WITH freq_cte AS (SELECT Year(Date) as Year, Month(Date) as month, 
Confirmed AS confirmed_cases, COUNT(*) as frequent_value From corona_virus_data
GROUP BY Confirmed,Year(Date), Month(Date) order by month)
SELECT* FROM freq_cte WHERE frequent_value = (SELECT max(frequent_value) FROM freq_cte);

-- frequent values for death cases
WITH freq_cte AS (SELECT Year(Date) as Year, Month(Date) as month, 
Deaths AS death_cases, COUNT(*) as frequent_value From corona_virus_data
GROUP BY Deaths,Year(Date), Month(Date) order by month)
SELECT* FROM freq_cte WHERE frequent_value = (SELECT max(frequent_value) FROM freq_cte);

-- frequent values for recovered cases
WITH freq_cte AS (SELECT Year(Date) as Year, Month(Date) as month, 
Recovered AS recovered_cases, COUNT(*) as frequent_value From corona_virus_data
GROUP BY Recovered,Year(Date), Month(Date) order by month)
SELECT* FROM freq_cte WHERE frequent_value = (SELECT max(frequent_value) FROM freq_cte);


-- Q8. Find minimum values for confirmed, deaths, recovered per year

SELECT 
    YEAR(Date) AS year, MIN(Confirmed) AS min_confirmed, MIN(Deaths) AS min_deaths, MIN(Recovered) AS min_recovered
FROM corona_virus_data
GROUP BY YEAR(Date)
ORDER BY year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS year, MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths, MAX(Recovered) AS max_recovered
FROM corona_virus_data
GROUP BY YEAR(Date)
ORDER BY year;

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT YEAR(Date) AS year, MONTH(Date) AS month, SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths, SUM(Recovered) AS total_recovered
FROM corona_virus_data
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY year, month;

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT COUNT(*) AS total_confirmed_case, ROUND(AVG(Confirmed), 2) AS Avg_Confirmed_Case, 
ROUND(variance(Confirmed),2) AS Variance_Confirmed_Case, 
ROUND(STDDEV(Confirmed),2) AS STDEV_Confirmed_Case
FROM corona_virus_data;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    YEAR(Date) AS year, MONTH(Date) AS month,
    SUM(Deaths) AS total_death_cases,  ROUND(AVG(Deaths),2) AS average_death_cases,
     ROUND(VARIANCE(Deaths),2) AS variance_death_cases,ROUND(STDDEV(Deaths),2) AS stdev_death_cases
     FROM corona_virus_data
GROUP BY YEAR(Date),MONTH(Date)
ORDER BY year, month;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT COUNT(*) AS total_Recovered_case, ROUND(AVG(Recovered), 2) AS Avg_Recovered_Case, 
ROUND(variance(Recovered),2) AS Variance_Recovered_Case, 
ROUND(STDDEV(Recovered),2) AS STDEV_Recovered_Case
FROM corona_virus_data;

-- Q14. Find Country having highest number of the Confirmed case

SELECT `Country/Region`, SUM(Confirmed) AS highest_confirmed_cases
FROM corona_virus_data
GROUP BY `Country/Region`
ORDER BY highest_confirmed_cases DESC
LIMIT 5;

-- Q15. Find Country having lowest number of the death case

SELECT `Country/Region`, SUM(Deaths) AS lowest_deaths_cases
FROM corona_virus_data
GROUP BY `Country/Region`
ORDER BY lowest_deaths_cases ASC
LIMIT 5;

-- Q16. Find top 5 countries having highest recovered case

SELECT `Country/Region`, SUM(Recovered) AS total_recovered
FROM corona_virus_data
GROUP BY `Country/Region`
ORDER BY total_recovered DESC
LIMIT 5;

