/* ============================================================
   GLOBAL CAUSES OF DEATH ANALYSIS (1990–2019)
   00_setup_notes.sql

   PURPOSE:
   Prepare the Our World in Data mortality dataset for the
   analysis contained in mortality_analysis.sql.

   This script:
   1. Creates the source table used for analysis.
   2. Loads the project CSV into SQL Server.
   3. Uses SQL friendly column names that match the analysis.
   4. Performs basic validation checks after loading.

   DATASET:
   data/annual-number-of-deaths-by-cause.csv

   SOURCE:
   Our World in Data

   REQUIREMENTS:
   - Microsoft SQL Server 2017 or later
   - SQL Server Management Studio (SSMS)
   - Access to the CSV file from SQL Server

   IMPORTANT:
   Update the file path in the BULK INSERT statement before
   running this script.
   ============================================================ */


-- ============================================================
-- 1. CREATE SOURCE TABLE
-- ============================================================

-- Recreate the source table so the setup can be run again
-- from a clean starting point.

DROP TABLE IF EXISTS dbo.Cdeath;

CREATE TABLE dbo.Cdeath
(
    Country VARCHAR(255),
    Code VARCHAR(50),
    Year INT,

    Meningitis BIGINT,
    AlzheimerDisease BIGINT,
    ParkinsonDisease BIGINT,
    Nutritional BIGINT,
    Malaria BIGINT,
    Drowning BIGINT,
    Interpersonalviolence BIGINT,
    MaternalDisorder BIGINT,
    HIV_AIDS BIGINT,
    DrugUse BIGINT,
    Tuberculosis BIGINT,
    CardiovascularDiseases BIGINT,
    RespiratoryInf BIGINT,
    NeonatalDisorder BIGINT,
    AlcoholUseDisorders BIGINT,
    Selfharm BIGINT,
    Expnature BIGINT,
    DiarrhealDiseases BIGINT,
    HeatColdExposure BIGINT,
    Neoplasms BIGINT,
    Conflict_terrorism BIGINT,
    Diabetes_mellitus BIGINT,
    KidneyDisease BIGINT,
    Poison BIGINT,
    Malnutrition BIGINT,
    Road_injuries BIGINT,
    Chronic_Respiratory_Diseases BIGINT,
    Chronic_Liver_Diseases BIGINT,
    Digestive_Diseases BIGINT,
    Fire_heat_hot_subs BIGINT,
    Acute_Hepatitis BIGINT,
    Measles BIGINT
);


-- ============================================================
-- 2. LOAD PROJECT DATASET
-- ============================================================

/*
The CSV stored in the repository uses the original descriptive
Our World in Data column names.

Because BULK INSERT loads columns by position, the data can be
loaded directly into the SQL friendly column names created above.

The column order in this table matches the column order in:

data/annual-number-of-deaths-by-cause.csv

CHANGE THE FILE PATH BELOW to the location of the CSV on your
computer before running the script.
*/

BULK INSERT dbo.Cdeath
FROM 'C:\CHANGE_THIS_PATH\annual-number-of-deaths-by-cause.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);


-- ============================================================
-- 3. VALIDATE DATA LOAD
-- ============================================================

-- Confirm the number of rows and year range loaded.

SELECT
    COUNT(*) AS TotalRows,
    MIN(Year) AS FirstYear,
    MAX(Year) AS LastYear
FROM dbo.Cdeath;


/*
Expected results for the dataset included with this project:

TotalRows: 6840
FirstYear: 1990
LastYear: 2019
*/


-- Review a sample of the imported data.

SELECT TOP 10 *
FROM dbo.Cdeath
ORDER BY
    Country,
    Year;


-- ============================================================
-- 4. COUNTRY VS. AGGREGATE RECORDS
-- ============================================================

/*
The dataset contains individual countries as well as regional,
income group, and global aggregate records.

Individual countries generally contain a value in the Code
column, while aggregate records may have a blank Code.

The main analysis uses this field when country only comparisons
are required.
*/

SELECT TOP 20
    Country,
    Code,
    Year
FROM dbo.Cdeath
ORDER BY
    Country,
    Year;


/* ============================================================
   SETUP COMPLETE

   After the validation checks succeed, run:

   sql/mortality_analysis.sql

   That script reshapes the wide source table into a temporary
   long format table and performs the mortality analysis.
   ============================================================ */
