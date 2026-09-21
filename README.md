###  Global Causes of Death Analysis (1990–2019)
** SQL Server | Tableau | Public Health Data Analysis **

An exploratory analysis of global mortality data from 1990–2019, examining how causes of death vary across countries and regions. Using SQL, I transformed and analyzed mortality data before taking a deeper look at alcohol related deaths, drug related deaths, and self harm/suicide trends.

Beyond identifying patterns in the data, I explored how socioeconomic conditions, public policy, and cultural factors may help provide context for differences observed between countries.

**[View the Interactive Tableau Dashboard](https://public.tableau.com/app/profile/travis.moore8794/viz/WorldCausesofDeathDashboard/Dashboard1)**

## Contents
  * [1. Leading Causes of Death Globally](#1-leading-causes-of-death-globally)
  * [2. Where Did Cardiovascular Disease Rank Differently?](#2-where-did-cardiovascular-disease-rank-differently)
  * [3. Alcohol, Drug Use, and Self-Harm Rankings](#3-alcohol-drug-use-and-self-harm-rankings)
  * [4. Looking Deeper: Sri Lanka and India](#4-looking-deeper-sri-lanka-and-india)
  * [5. Comparing Selected Countries With the Global Average](#5-comparing-selected-countries-with-the-global-average)
* [What Did I Learn?](#what-did-i-learn)
* [Limitations](#limitations)
* [Conclusion](#conclusion)

## Goal of this project:
---
The goal of this project was to explore global mortality trends between 1990 and 2019 and identify how leading causes of death differed across countries and regions.

After examining broader mortality patterns, I focused the analysis on three areas that stood out to me: alcohol use, drug use, and self harm/suicide. I used SQL to compare mortality rankings, examine changes over time, and investigate differences between countries.

The analysis was guided by three main questions:
1) What were the leading causes of death globally between 1990 and 2019?
2) Which countries showed notable differences in alcohol, drug, and self harm related deaths?
3) What cultural, socioeconomic, or public policy factors might provide context for some of the patterns found in the data?

## Data Source:
---
The dataset used for this project was obtained from "Our World in Data" and contains annual mortality data from 1990–2019 across countries, regions, and income groups.

The dataset includes:
* Country or region
* Year
* Number of deaths by cause
* Multiple mortality categories, including cardiovascular disease, alcohol use disorders, drug use, self harm, infectious diseases, and other causes

The exact dataset snapshot used for this analysis is preserved in the repository so the project can be reproduced even if the original source dataset changes in the future.

**Original Dataset:** [Our World in Data](https://ourworldindata.org/grapher/annual-number-of-deaths-by-cause)

**Project Dataset:** [`data/annual-number-of-deaths-by-cause.csv`](data/annual-number-of-deaths-by-cause.csv)

## Tools used:
---
* Microsoft SQL Server — Data transformation, cleaning, aggregation, ranking, and exploratory analysis
* Tableau — Data visualization and dashboard development
* GitHub — Project documentation and version control

## Reproducing the Analysis

The SQL portion of this project can be reproduced using Microsoft SQL Server and SQL Server Management Studio (SSMS).

1. Clone or download this repository.
2. Open SQL Server Management Studio and connect to a SQL Server database.
3. Open sql/00_setup_notes.sql.
4. Update the CSV file path in the BULK INSERT statement so that it points to:

data/annual-number-of-deaths-by-cause.csv

5. Run 00_setup_notes.sql.

The setup script:
* Creates the Cdeath source table
* Loads the project CSV
* Assigns column names
* Performs basic row count and year range validation
  
6. Confirm that the validation query returns 6,840 records covering 1990–2019.

7. Run sql/mortality_analysis.sql.

The analysis script transforms the original wide dataset into a long format temporary table using SQL Server UNPIVOT. It then performs the exploratory analysis, country level rankings, trend analysis, and country average comparisons described below.

The Tableau dashboard represents the visualization portion of the project and can be viewed through the dashboard link at the top of this README.

## Data Transformation:
---
The original dataset stored each cause of death in a separate column. Before performing the analysis, I restructured the data into a format that made comparisons, aggregations, and ranking easier to perform in SQL.

1. Standardized Column Names
The repository includes a setup script that loads the original CSV into SQL Server and assigns shorter column names while preserving the underlying data.

For example: 
Deaths - Cardiovascular diseases - Sex: Both - Age: All Ages (Number) → CardiovascularDiseases
Deaths - Alcohol use disorders - Sex: Both - Age: All Ages (Number) → AlcoholUseDisorders
Deaths - Self-harm - Sex: Both - Age: All Ages (Number) → Selfharm

2. Reshaped the Dataset with UNPIVOT
The original dataset was structured in a wide format, with individual causes of death stored across multiple columns. I used SQL Server's UNPIVOT operation to transform these columns into two fields:

* Causes — the cause of death category
* Total_deaths — the corresponding number of deaths

This created a more analysis friendly structure:

Country | Year | Causes | Total_deaths

Restructuring the data allowed me to aggregate deaths by cause, compare countries, analyze changes over time, and rank causes of death using the same table structure.

3. Created a Temporary Analysis Table
Because the transformed data was used repeatedly throughout the project, I stored the UNPIVOT results in a temporary table rather than rewriting the transformation for every query.

I also retained the `Code` field so I could distinguish individual country records from regional and aggregate entries later in the analysis.

The transformed records were inserted into #Cdeath1, which became the primary table used throughout the exploratory analysis.

---
## Analysis

The SQL analysis explores global mortality patterns across countries and causes of death, with additional focus on alcohol use disorders, drug use, and self harm.

The analysis includes:

- Leading global causes of death
- Country-level cause rankings
- Alcohol-related mortality
- Drug-related mortality
- Self-harm mortality
- Sri Lanka and India trend comparisons
- Country totals compared with average country totals
- Focused country case studies

For the full analysis and interpretation of the results, see:
[View Full Analysis](analysis.md)
