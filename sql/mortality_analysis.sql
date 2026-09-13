/* ============================================================
   GLOBAL CAUSES OF DEATH ANALYSIS (1990–2019)

   Purpose:
   Explore global mortality patterns using Microsoft SQL Server,
   with additional analysis focused on alcohol use disorders,
   drug use, and self harm.

   Dataset Source:
   Our World in Data
   ============================================================ */

-- ============================================================
-- 1. DATA PREPARATION
-- ============================================================

-- Rename Entity column to Country for readability
EXEC sp_rename 'Cdeath.Entity', 'Country', 'COLUMN';

-- ============================================================
-- 2. RESHAPE DATA
-- ============================================================

-- Create temporary table to store the transformed dataset
-- Code is retained so country-level records can be separated
-- from regional and aggregate rows later in the analysis

CREATE TABLE #Cdeath1
(
    Country VARCHAR(255),
    Code VARCHAR(50),
    Year NVARCHAR(255),
    Causes VARCHAR(255),
    Total_deaths BIGINT
);


-- Transform the original wide dataset into a long format
-- using UNPIVOT and insert the results into the temporary table

INSERT INTO #Cdeath1
(
    Country,
    Code,
    Year,
    Causes,
    Total_deaths
)

SELECT
    Country,
    Code,
    Year,
    Causes,
    Total_deaths
FROM
(
    SELECT
        Country,
        Code,
        Year,
        Meningitis,
        AlzheimerDisease,
        ParkinsonDisease,
        Nutritional,
        Malaria,
        Drowning,
        Interpersonalviolence,
        MaternalDisorder,
        HIV_AIDS,
        DrugUse,
        Tuberculosis,
        CardiovascularDiseases,
        RespiratoryInf,
        NeonatalDisorder,
        AlcoholUseDisorders,
        Selfharm,
        Expnature,
        DiarrhealDiseases,
        HeatColdExposure,
        Neoplasms,
        Conflict_terrorism,
        Diabetes_mellitus,
        KidneyDisease,
        Poison,
        Malnutrition,
        Road_injuries,
        Chronic_Respiratory_Diseases,
        Chronic_Liver_Diseases,
        Digestive_Diseases,
        Fire_heat_hot_subs,
        Acute_Hepatitis,
        Measles
    FROM Cdeath
) AS maint

UNPIVOT
(
    Total_deaths FOR Causes IN
    (
        Meningitis,
        AlzheimerDisease,
        ParkinsonDisease,
        Nutritional,
        Malaria,
        Drowning,
        Interpersonalviolence,
        MaternalDisorder,
        HIV_AIDS,
        DrugUse,
        Tuberculosis,
        CardiovascularDiseases,
        RespiratoryInf,
        NeonatalDisorder,
        AlcoholUseDisorders,
        Selfharm,
        Expnature,
        DiarrhealDiseases,
        HeatColdExposure,
        Neoplasms,
        Conflict_terrorism,
        Diabetes_mellitus,
        KidneyDisease,
        Poison,
        Malnutrition,
        Road_injuries,
        Chronic_Respiratory_Diseases,
        Chronic_Liver_Diseases,
        Digestive_Diseases,
        Fire_heat_hot_subs,
        Acute_Hepatitis,
        Measles
    )
) AS unpivottable;

-- Verify the transformed dataset

SELECT *
FROM #Cdeath1;

-- ============================================================
-- 3. EXPLORATORY ANALYSIS
-- ============================================================

-- ============================================================
-- 3.1 INSPECT COUNTRIES AND REGIONS
-- ============================================================

-- View all unique countries, regions, and aggregate groups
-- contained in the transformed dataset

SELECT DISTINCT
    Country
FROM #Cdeath1
ORDER BY Country;


/*
Optional examples for exploring specific entries:

WHERE Country LIKE '%United States%'
WHERE Country LIKE '%Income%'
*/

-- ============================================================
-- 3.2 TOP 10 GLOBAL CAUSES OF DEATH
-- ============================================================

-- Use the dataset's World aggregate rather than summing
-- countries, regions, and income groups together

SELECT TOP 10
    Causes,
    SUM(Total_deaths) AS TotalNumberDeaths
FROM #Cdeath1
WHERE Country = 'World'
GROUP BY Causes
ORDER BY TotalNumberDeaths DESC;

-- ============================================================
-- 3.3 COMPARE CAUSES OF DEATH ACROSS SELECTED COUNTRIES
-- ============================================================

-- Compare total deaths by cause across selected countries
-- to identify differences in mortality patterns

SELECT
    Country,
    Causes,
    SUM(Total_deaths) AS TotalNumberDeaths
FROM #Cdeath1
WHERE Country IN
(
    'Nigeria',
    'India',
    'Kenya',
    'Bangladesh',
    'Pakistan'
)
GROUP BY
    Country,
    Causes
ORDER BY
    Country,
    TotalNumberDeaths DESC;

-- ============================================================
-- 3.4 RANK CAUSES OF DEATH WITHIN EACH COUNTRY
-- ============================================================

-- Rank each cause of death within every country based on
-- the total number of deaths recorded from 1990–2019

WITH Ranked_causes AS
(
    SELECT
        Country,
        Causes,
        SUM(Total_deaths) AS TotalNumberDeaths,
        RANK() OVER
        (
            PARTITION BY Country
            ORDER BY SUM(Total_deaths) DESC
        ) AS RankNumber
    FROM #Cdeath1
    WHERE NULLIF(LTRIM(RTRIM(Code)), '') IS NOT NULL
    GROUP BY
         Country,
         Causes 
)

SELECT
    Country,
    Causes,
    TotalNumberDeaths,
    RankNumber
FROM Ranked_causes
ORDER BY
     Country,
     RankNumber;
 -- ============================================================
-- COUNTRIES WHERE CARDIOVASCULAR DISEASE IS NOT A TOP 5 CAUSE
-- ============================================================

WITH Ranked_causes AS
(
    SELECT
        Country,
        Causes,
        SUM(Total_deaths) AS TotalNumberDeaths,
        RANK() OVER
        (
            PARTITION BY Country
            ORDER BY SUM(Total_deaths) DESC
        ) AS RankNumber
    FROM #Cdeath1
    WHERE NULLIF(LTRIM(RTRIM(Code)), '') IS NOT NULL
    GROUP BY
         Country,
         Causes
)

SELECT
    Country,
    Causes,
    TotalNumberDeaths,
    RankNumber
FROM Ranked_causes
WHERE Country NOT IN
(
    SELECT Country
    FROM Ranked_causes
    WHERE Causes = 'CardiovascularDiseases'
      AND RankNumber <= 5
)
ORDER BY
    Country,
    RankNumber;

-- ============================================================
-- 3.5 ALCOHOL-RELATED MORTALITY RANKINGS
-- ============================================================

-- Identify countries where alcohol-related deaths ranked
-- among the top 10 causes of death from 1990–2019

WITH Ranked_causes AS
(
    SELECT
        Country,
        Causes,
        SUM(Total_deaths) AS TotalNumberDeaths,
        RANK() OVER
        (
            PARTITION BY Country
            ORDER BY SUM(Total_deaths) DESC
        ) AS RankNumber
    FROM #Cdeath1
    WHERE NULLIF(LTRIM(RTRIM(Code)), '') IS NOT NULL
    GROUP BY
        Country,
        Causes
)

SELECT
    Country,
    Causes,
    TotalNumberDeaths,
    RankNumber
FROM Ranked_causes
WHERE Causes LIKE '%Alcohol%'
  AND RankNumber <= 10
ORDER BY
    RankNumber,
    TotalNumberDeaths DESC;
-- ============================================================
-- 3.6 DRUG-RELATED MORTALITY RANKINGS
-- ============================================================

-- Identify countries where drug-related deaths ranked
-- among the top 15 causes of death from 1990–2019

WITH Ranked_causes AS
(
    SELECT
        Country,
        Causes,
        SUM(Total_deaths) AS TotalNumberDeaths,
        RANK() OVER
        (
            PARTITION BY Country
            ORDER BY SUM(Total_deaths) DESC
        ) AS RankNumber
    FROM #Cdeath1
    WHERE NULLIF(LTRIM(RTRIM(Code)), '') IS NOT NULL
    GROUP BY
        Country,
        Causes
)

SELECT
    Country,
    Causes,
    TotalNumberDeaths,
    RankNumber
FROM Ranked_causes
WHERE Causes LIKE '%Drug%'
  AND RankNumber <= 15
ORDER BY
    RankNumber,
    TotalNumberDeaths DESC;

-- ============================================================
-- 3.7 SELF-HARM / SUICIDE MORTALITY RANKINGS
-- ============================================================

-- Identify countries where self-harm ranked among
-- the top 10 causes of death from 1990–2019

WITH Ranked_causes AS
(
    SELECT
        Country,
        Causes,
        SUM(Total_deaths) AS TotalNumberDeaths,
        RANK() OVER
        (
            PARTITION BY Country
            ORDER BY SUM(Total_deaths) DESC
        ) AS RankNumber
    FROM #Cdeath1
    WHERE NULLIF(LTRIM(RTRIM(Code)), '') IS NOT NULL
    GROUP BY
        Country,
        Causes
)

SELECT
    Country,
    Causes,
    TotalNumberDeaths,
    RankNumber
FROM Ranked_causes
WHERE Causes LIKE '%Selfharm%'
  AND RankNumber <= 10
ORDER BY
    RankNumber,
    TotalNumberDeaths DESC;


-- Compare countries where self-harm ranked lower
-- relative to other causes of death

WITH Ranked_causes AS
(
    SELECT
        Country,
        Causes,
        SUM(Total_deaths) AS TotalNumberDeaths,
        RANK() OVER
        (
            PARTITION BY Country
            ORDER BY SUM(Total_deaths) DESC
        ) AS RankNumber
    FROM #Cdeath1
    WHERE NULLIF(LTRIM(RTRIM(Code)), '') IS NOT NULL
    GROUP BY
        Country,
        Causes
)

SELECT
    Country,
    Causes,
    TotalNumberDeaths,
    RankNumber
FROM Ranked_causes
WHERE Causes LIKE '%Selfharm%'
  AND RankNumber > 10
ORDER BY
    RankNumber,
    TotalNumberDeaths DESC;

-- ============================================================
-- 3.8 SRI LANKA SELF HARM TREND OVER TIME
-- ============================================================

-- Examine annual self harm deaths in Sri Lanka from 1990–2019
-- to identify how mortality changed over time

SELECT
    Country,
    Year,
    Causes,
    Total_deaths
FROM #Cdeath1
WHERE Country = 'Sri Lanka'
  AND Causes = 'Selfharm'
ORDER BY Year;

-- ============================================================
-- 3.9 COMPARE SELF-HARM TRENDS: SRI LANKA VS. INDIA
-- ============================================================

-- Compare annual self-harm deaths in Sri Lanka and India
-- to examine how trends differed between the two countries

SELECT
    Country,
    Year,
    Total_deaths
FROM #Cdeath1
WHERE Country IN ('Sri Lanka', 'India')
  AND Causes = 'Selfharm'
ORDER BY
    Year,
    Country;

-- ============================================================
-- 3.10 COMPARE COUNTRY TOTALS WITH THE GLOBAL AVERAGE
-- ============================================================

-- First calculate the total number of deaths for each
-- actual country and cause across the full 1990–2019 period

WITH CountryCauseTotals AS
(
    SELECT
        Country,
        Causes,
        SUM(Total_deaths) AS CountryTotalDeaths
    FROM #Cdeath1
    WHERE NULLIF(LTRIM(RTRIM(Code)), '') IS NOT NULL
    GROUP BY
        Country,
        Causes
),

-- Calculate the average country total for each cause of death

GlobalCauseAverages AS
(
    SELECT
        Causes,
        AVG(CAST(CountryTotalDeaths AS DECIMAL(18,2))) AS GlobalAverageDeaths
    FROM CountryCauseTotals
    GROUP BY Causes
)

SELECT
    c.Country,
    c.Causes,
    c.CountryTotalDeaths,
    g.GlobalAverageDeaths,
    c.CountryTotalDeaths - g.GlobalAverageDeaths AS DifferenceFromGlobalAvg
FROM CountryCauseTotals c
JOIN GlobalCauseAverages g
    ON c.Causes = g.Causes

-- Optional filters:
-- WHERE c.Causes LIKE '%Alcohol%'
-- WHERE c.Causes LIKE '%Drug%'
-- WHERE c.Causes LIKE '%Selfharm%'

ORDER BY DifferenceFromGlobalAvg DESC;

-- ============================================================
-- 3.11 FOCUSED GLOBAL AVERAGE CASE STUDIES
-- ============================================================

-- Compare selected country/cause combinations that stood out
-- during the exploratory analysis

WITH CountryCauseTotals AS
(
    SELECT
        Country,
        Causes,
        SUM(Total_deaths) AS CountryTotalDeaths
    FROM #Cdeath1
    WHERE NULLIF(LTRIM(RTRIM(Code)), '') IS NOT NULL
    GROUP BY
        Country,
        Causes
),

GlobalCauseAverages AS
(
    SELECT
        Causes,
        AVG(CAST(CountryTotalDeaths AS DECIMAL(18,2))) AS GlobalAverageDeaths
    FROM CountryCauseTotals
    GROUP BY Causes
)

SELECT
    c.Country,
    c.Causes,
    c.CountryTotalDeaths,
    g.GlobalAverageDeaths,
    c.CountryTotalDeaths - g.GlobalAverageDeaths AS DifferenceFromGlobalAvg
FROM CountryCauseTotals c
JOIN GlobalCauseAverages g
    ON c.Causes = g.Causes
WHERE
       (c.Country = 'Nigeria' AND c.Causes LIKE '%Alcohol%')
    OR (c.Country = 'Iran'    AND c.Causes LIKE '%Drug%')
    OR (c.Country = 'Japan'   AND c.Causes LIKE '%Selfharm%')
ORDER BY
    c.Country,
    c.Causes;

