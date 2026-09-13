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

**Original Dataset:** [Our World in Data](https://ourworldindata.org/grapher/annual-number-of-deaths-by-cause)

**Project Dataset:** [`data/annual-number-of-deaths-by-cause.csv`](data/annual-number-of-deaths-by-cause.csv)

## Tools used:
---
* Microsoft SQL Server — Data transformation, cleaning, aggregation, ranking, and exploratory analysis
* Tableau — Data visualization and dashboard development
* GitHub — Project documentation and version control


## Data Transformation:
---
The original dataset stored each cause of death in a separate column. Before performing the analysis, I restructured the data into a format that made comparisons, aggregations, and ranking easier to perform in SQL.

1. Standardized Column Names
I renamed the Entity field to Country to make the column more intuitive throughout the analysis.

EXEC sp_rename 'Cdeath.Entity', 'Country', 'COLUMN';

2. Reshaped the Dataset with UNPIVOT
The original dataset was structured in a wide format, with individual causes of death stored across multiple columns. I used SQL Server's UNPIVOT operation to transform these columns into two fields:

* Causes — the cause of death category
* Total_deaths — the corresponding number of deaths

This created a more analysis friendly structure:

Country | Year | Causes | Total_deaths

Restructuring the data allowed me to aggregate deaths by cause, compare countries, analyze changes over time, and rank causes of death using the same table structure.

3. Created a Temporary Analysis Table
Because the transformed data was used repeatedly throughout the project, I stored the UNPIVOT results in a temporary table rather than rewriting the transformation for every query.

CREATE TABLE #Cdeath1
(
    Country VARCHAR(255),
    Code VARCHAR(50),
    Year NVARCHAR(255),
    Causes VARCHAR(255),
    Total_deaths BIGINT
);

I also retained the `Code` field so I could distinguish individual country records from regional and aggregate entries later in the analysis.

The transformed records were inserted into #Cdeath1, which became the primary table used throughout the exploratory analysis.

This process changed the dataset from a wide reporting structure into a format that was much easier to query and analyze using SQL.

---
## Analysis
After transforming the dataset into a more analysis friendly structure, I used SQL to explore mortality patterns at several levels: globally, across individual countries, over time, and within specific causes of death.

The analysis began with broad questions about the leading causes of death worldwide and gradually narrowed into areas that stood out in the results.

### Analysis Workflow

1. Identify the leading causes of death globally.
2. Compare mortality patterns across selected countries.
3. Rank causes of death within each country.
4. Explore countries where alcohol, drug, and self harm/suicide related deaths ranked unusually high or low.
5. Examine self harm trends over time in Sri Lanka and India.
6. Compare selected country level mortality totals with global averages.
7. Use the results to identify cases for deeper public health research.

> **Full SQL Analysis:** [`sql/mortality_analysis.sql`](sql/mortality_analysis.sql)

---

### 1. Leading Causes of Death Globally

The first question I wanted to answer was:

What were the Top 10 Causes of Death globally between 1990 and 2019?

Using the dataset's World data, I grouped each cause of death and calculated the total number of deaths across the full time period.

Here we can see that cardiovascular disease was the leading cause of death worldwide, followed by Chronic Respiratory Diseases, Respiratory Infections, Neonatal Disorders, Digestive Diseases, Diarrheal Diseases, Tuberculosis, Chronic Liver Diseases, and Road Injuries.

While understanding which causes of death had the greatest global impact was helpful, I also wanted to look deeper.

Did these same patterns appear across individual countries, or were there places where certain causes of death had a much different impact?

That question led me into the next part of the analysis.

### 2. Where Did Cardiovascular Disease Rank Differently?

While understanding which causes of death had the greatest global impact was helpful, I also wanted to look at countries where the pattern was different.

**Which countries did not have cardiovascular disease within their Top 5 causes of death?**

To answer this, I ranked each cause of death within individual countries and used a CTE to filter the results.

Several countries, including **Burkina Faso, Malawi, Nigeria, Niger, Somalia, and Côte d'Ivoire**, stood out.

This did not necessarily mean that these countries experienced fewer cardiovascular deaths overall. Instead, other causes of death held a higher ranking within their mortality profiles, including **Malaria, HIV/AIDS, and Diarrheal Diseases**.

This made me think more about how mortality patterns can differ depending on the health challenges affecting a particular country.

From here, three categories caught my attention:

* **Alcohol use**
* **Drug use**
* **Self harm/Suicide**

My next goal was to find out which countries had higher or lower rankings for deaths related to each of these categories.

### 3. Alcohol, Drug Use, and Self Harm Rankings

When exploring the different causes of death by country, I became especially interested in three categories:

* **Alcohol use**
* **Drug use**
* **Self harm/Suicide**

My first goal was to find out which countries had higher or lower rankings for deaths related to each of these causes.

#### Alcohol Related Deaths

I first looked at countries where alcohol related deaths ranked within their **Top 10 causes of death**.

A pattern started to emerge. Several European countries appeared higher in the rankings, with **Ukraine** standing out as alcohol use disorder deaths ranked relatively high compared with other causes of death within the country.

This gave me an opportunity to dig deeper:

**Why were alcohol related deaths ranking so highly in some of these countries?**

#### Drug Related Deaths

Next, I looked at countries where drug  related deaths ranked within their **Top 15 causes of death**.

Seeing the **United States** high on the list was not unexpected, but I was more surprised by some of the results within the United Kingdom, particularly **Scotland**.

That raised another question:

**What factors might help explain why drug related mortality ranked so highly in certain countries?**

#### Self Harm / Suicide

Finally, I looked at countries where self harm ranked within their **Top 10 causes of death**.

One result that immediately stood out to me was **Sri Lanka**. This pushed me to look beyond the ranking itself and investigate why self-harm deaths had such a large impact within the country.

From here, I wanted to understand how Sri Lanka's self harm deaths had changed over time and whether comparing the trend with another country could provide more context.

**SQL:** [View the full analysis](sql/mortality_analysis.sql)

### 4. Looking Deeper: Sri Lanka and India

Seeing **Sri Lanka** rank so highly for self harm deaths made me want to understand how those deaths had changed over time.

**Had self harm deaths remained consistently high, or had the pattern changed between 1990 and 2019?**

When looking at Sri Lanka year by year, the data showed a sharp increase during the 1990s, followed by a noticeable decline in later years.

This made me ask another question:

**What may have contributed to that decrease?**

One area that stood out in my research was Sri Lanka's restriction of highly toxic pesticides. Because pesticide self-poisoning had been an important contributor to suicide deaths within the country, these policy changes provided an interesting area for further investigation.

But looking at one country alone did not tell the full story.

I then compared Sri Lanka with **India** to see whether a neighboring country showed a similar pattern.

The trends were noticeably different, which reinforced something that became increasingly clear throughout this project: mortality patterns cannot always be understood through the numbers alone. Access to healthcare, economic conditions, public policy, culture, and other factors may all provide important context for what appears in the data.

**SQL:** [View the full analysis](sql/mortality_analysis.sql)

### 5. Comparing Selected Countries With the Global Average

Another question I wanted to answer was:

**How do certain causes of death within individual countries compare with the average across other countries?**

To explore this, I calculated each country's total deaths by cause and compared those totals with the average country total for the same cause.

This gave me another way to identify countries that stood out and decide where I wanted to dig deeper.

#### Alcohol Related Deaths: Nigeria

When looking at alcohol related deaths, countries such as Ukraine continued to appear high in the results, which aligned with what I had already seen earlier in the analysis.

However, I was surprised to see **Nigeria** stand out compared with the average.

This made me ask:

**Why might alcohol related mortality be elevated in Nigeria?**

In my additional research, I found that several factors may provide context, including population size, the availability of locally produced alcoholic beverages, cultural attitudes toward alcohol, and challenges surrounding the implementation of alcohol control policies.

This was another example of how the numbers could point me toward a pattern, but outside research was needed to better understand what might be happening behind it.

#### Drug Related Deaths: Iran

Next, I wanted to explore **Iran**, where drug related deaths also stood out in comparison with the average.

This result raised more questions for me because Iran is located near countries such as Afghanistan and Pakistan, and I wanted to understand whether geography, drug trafficking routes, policy, and access to harm reduction services may help provide context for what I was seeing.

My research suggested that Iran's proximity to major opium producing and trafficking regions may be one factor worth considering, along with the country's strict drug laws and approach to harm reduction.

Again, the data did not explain *why* the pattern existed, but it helped me identify where deeper questions were worth asking.

#### Self Harm / Suicide: Japan

Finally, I looked more closely at **Japan** and self harm related deaths.

This led me to think about how work culture, social pressures, and suicide prevention policies may interact with mortality trends over time.

In my research, I came across concepts such as **karoshi** and **karojisatsu**, as well as national suicide prevention efforts implemented in Japan.

What interested me most here was not just the mortality number itself, but how policy, culture, and social conditions may all influence the way a health issue develops within a country.

## What Did I Learn?
Through this analysis, several things became clear to me.

### Mortality is complex

Causes of death are influenced by more than one factor. Socioeconomic conditions, healthcare access, culture, geography, and public policy may all help explain why mortality patterns look different across countries.

### Countries can have very different health priorities

Looking at the rankings showed me that the leading causes of death are not always the same everywhere. In some countries, infectious diseases such as Malaria, HIV/AIDS, and Diarrheal Diseases held a much higher priority than causes that dominated globally.

### Policy can matter

Sri Lanka was one of the clearest examples that made me think more about the relationship between policy and health outcomes. After seeing changes in self harm deaths over time, I became interested in how pesticide restrictions may have contributed to the decline.

### The data can tell you where to look, but not always why

One of the biggest things I learned from this project was that SQL can help identify patterns, differences, and outliers, but the data alone does not always explain why those patterns exist.

That is where additional research becomes important.
The most interesting part of this project for me was being able to use the data to ask better questions and then explore how public policy, culture, healthcare systems, and socioeconomic conditions may provide additional context.

### Data analysis can support better questions

This project helped me see how tools such as SQL can be used not only to organize and analyze large datasets, but also to identify areas where deeper research may be useful.

For me, that became one of the biggest takeaways from the project:

**The value of data is not only in finding the answer. Sometimes it is in helping you figure out what question to ask next.**

## Limitations
While this project helped me identify several interesting mortality patterns, there are some limitations to keep in mind.

The dataset only covers **1990–2019**, so more recent changes in mortality trends, healthcare policy, and public health interventions are not included.

The data also helped me identify patterns and differences between countries, but it cannot by itself explain why those differences exist. Factors such as culture, socioeconomic conditions, healthcare access, geography, and policy require additional research and should not be treated as proven causes based on this dataset alone.

Another limitation is that this analysis primarily used total death counts. Population size and age distribution can influence those totals, so future analysis could also include population adjusted mortality rates to make comparisons between countries more precise.

These limitations also gave me ideas for how I could expand the project in the future.

## Conclusion
This project started with a broad question about the leading causes of death around the world, but as I continued exploring the data, it became clear that the most interesting part was understanding **why certain countries looked different from others**.

Using SQL allowed me to identify patterns, rank causes of death, compare countries, and follow changes over time. From there, the analysis pushed me to ask deeper questions about public policy, healthcare access, socioeconomic conditions, culture, and geography.

One of the biggest things I took away from this project is that data can show us where something interesting is happening, but it does not always explain why. This project was helpful in allowing me to combine technical analysis with my interest in public health and use the results to guide further research into the factors that may influence health outcomes across different countries.

There are still many directions this analysis could go, including the use of population adjusted mortality rates, additional socioeconomic datasets, and more recent mortality data.

For now, this project gave me a stronger understanding of how SQL can be used to move from a large dataset to more focused questions and meaningful insights.
