# Global Causes of Death Analysis

## 1. Leading Causes of Death Globally

The first question I wanted to answer was:

**What were the Top 10 causes of death globally between 1990 and 2019?**

Using the dataset's `World` data, I grouped each cause of death and calculated the total number of deaths across the full time period.

The results showed that cardiovascular disease was the leading cause of death worldwide. Other major causes included chronic respiratory diseases, respiratory infections, neonatal disorders, digestive diseases, diarrheal diseases, tuberculosis, chronic liver diseases, and road injuries.

While understanding which causes of death had the greatest global impact was helpful, I also wanted to look deeper.

**Did these same patterns appear across individual countries, or were there places where certain causes of death had a very different impact?**

That question led me into the next part of the analysis.

---

## 2. Where Did Cardiovascular Disease Rank Differently?

After looking at the global results, I wanted to identify countries where the mortality pattern differed.

**Which countries did not have cardiovascular disease within their Top 5 causes of death?**

To answer this, I ranked each cause of death within individual countries and used a CTE to filter the results.

Several countries stood out, including:

* Burkina Faso
* Malawi
* Nigeria
* Niger
* Somalia
* Côte d'Ivoire

This did not necessarily mean that these countries experienced fewer cardiovascular deaths overall. Instead, other causes of death ranked higher within their mortality profiles, including malaria, HIV/AIDS, and diarrheal diseases.

This made me think more about how mortality patterns can differ depending on the health challenges affecting a particular country.

From here, three categories caught my attention:

* Alcohol use disorders
* Drug use
* Self harm

My next goal was to determine which countries had relatively high or low rankings for deaths associated with these categories.

---

## 3. Alcohol, Drug Use, and Self Harm Rankings

### Alcohol Related Deaths

I first looked at countries where alcohol use disorder deaths ranked within their Top 10 causes of death.

A pattern started to emerge. Several European countries appeared relatively high in the rankings, with Ukraine standing out because alcohol use disorder deaths ranked highly compared with other causes of death within the country.

This gave me another question to explore:

**Why were alcohol related deaths ranking so highly in some of these countries?**

### Drug Related Deaths

Next, I looked at countries where drug related deaths ranked within their Top 15 causes of death.

Seeing the United States high on the list was not unexpected, but I was more surprised by some of the results within the United Kingdom, particularly Scotland.

That raised another question:

**What factors might help explain why drug related mortality ranked so highly in certain countries?**

### Self Harm

Finally, I looked at countries where self harm ranked within their Top 10 causes of death.

One result that immediately stood out to me was Sri Lanka. This pushed me to look beyond the ranking itself and investigate how self harm deaths had changed over time.

From there, I wanted to determine whether comparing Sri Lanka with another country could provide additional context.

---

## 4. Looking Deeper: Sri Lanka and India

Seeing Sri Lanka rank highly for self harm deaths made me want to understand how those deaths had changed over time.

**Had self harm deaths remained consistently high, or had the pattern changed between 1990 and 2019?**

When looking at Sri Lanka year by year, the data showed a sharp increase during the 1990s, followed by a noticeable decline in later years.

This raised another question:

**What may have contributed to that decrease?**

One area that stood out in my additional research was Sri Lanka's restriction of highly toxic pesticides. Because pesticide self poisoning had been an important contributor to suicide deaths within the country, these policy changes became an interesting area for further investigation.

However, looking at one country alone did not tell the full story.

I then compared Sri Lanka with India to see whether a neighboring country showed a similar pattern.

The trends were noticeably different. This reinforced something that became increasingly clear throughout the project: mortality patterns cannot always be understood through the numbers alone.

Healthcare access, economic conditions, public policy, culture, and other factors may all provide important context for what appears in the data.

---

## 5. Comparing Selected Countries With the Average Country Total

Another question I wanted to answer was:

**How do certain causes of death within individual countries compare with the average country total for the same cause?**

To explore this, I calculated each country's total deaths by cause and compared those totals with the average across countries for that same cause.

This gave me another way to identify countries that stood out and decide where deeper investigation might be useful.

### Alcohol Related Deaths: Nigeria

When looking at alcohol related deaths, countries such as Ukraine continued to appear prominently, which aligned with what I had already seen in the rankings.

However, I was surprised to see Nigeria stand out when compared with the average country total.

This made me ask:

**What factors might provide context for alcohol related mortality in Nigeria?**

My additional research pointed toward several areas worth considering, including population size, locally produced alcoholic beverages, cultural attitudes toward alcohol, and challenges surrounding the implementation of alcohol control policies.

The mortality data itself does not establish that these factors caused the pattern. Instead, it identified an area where additional public health research could provide useful context.

### Drug Related Deaths: Iran

Next, I explored Iran, where drug related deaths also stood out compared with the average country total.

This raised additional questions because of Iran's geographic location near Afghanistan and Pakistan.

I wanted to understand whether factors such as geography, drug trafficking routes, drug policy, and access to harm reduction services might provide context for the pattern.

My additional research suggested that Iran's proximity to major opium producing and trafficking regions may be relevant, along with the country's drug policies and approach to harm reduction.

Again, the mortality data did not explain why the pattern existed. Instead, it helped identify where deeper questions were worth asking.

### Self Harm: Japan

Finally, I looked more closely at Japan and self harm deaths.

This led me to explore how social pressures, working conditions, and suicide prevention policies may relate to mortality trends over time.

During my research, I came across concepts such as *karoshi* and *karojisatsu*, as well as national suicide prevention efforts implemented in Japan.

What interested me most was not only the mortality number itself, but how policy, culture, social conditions, and healthcare systems may provide additional context for public health outcomes.

---

## What Did I Learn?

### Mortality is complex

Causes of death are influenced by many factors. Socioeconomic conditions, healthcare access, culture, geography, and public policy may all help explain why mortality patterns differ across countries.

### Countries can have very different health priorities

The rankings showed that the leading causes of death are not always the same everywhere.

In some countries, infectious diseases such as malaria, HIV/AIDS, and diarrheal diseases ranked much higher than causes that dominated the global results.

### Policy may provide important context

Sri Lanka was one of the clearest examples that made me think more about the relationship between policy and health outcomes.

After observing changes in self harm deaths over time, I became interested in research examining whether pesticide restrictions may have contributed to the decline.

### Data can tell you where to look, but not always why

One of the biggest things I learned from this project was that SQL can identify patterns, differences, and outliers, but the data alone does not necessarily explain why those patterns exist.

That is where additional research becomes important.

One of the most interesting parts of the project was using the data to ask better questions and then exploring how public policy, culture, healthcare systems, geography, and socioeconomic conditions might provide additional context.

### Data analysis can support better questions

This project helped me see how SQL can be used not only to organize and analyze large datasets, but also to identify areas where deeper research may be useful.

For me, one of the biggest takeaways was:

> **The value of data is not only in finding the answer. Sometimes it is in helping you figure out what question to ask next.**

---

## Limitations

While this project helped identify several interesting mortality patterns, there are important limitations to keep in mind.

The dataset covers 1990–2019, so more recent changes in mortality trends, healthcare policy, and public health interventions are not included.

The data can identify patterns and differences between countries, but it cannot independently explain why those differences exist. Factors such as culture, socioeconomic conditions, healthcare access, geography, and public policy require additional research and should not be treated as proven causes based on this dataset alone.

The analysis also primarily uses total death counts. Population size and age distribution can strongly influence these totals, meaning that comparisons between countries should be interpreted carefully.

A future version of the analysis could incorporate population adjusted or age standardized mortality rates to make comparisons between countries more precise.

These limitations also provide possible directions for expanding the project in the future.

---

## Conclusion

This project started with a broad question about the leading causes of death around the world, but as I continued exploring the data, the most interesting part became understanding why certain countries looked different from others.

Using SQL allowed me to identify patterns, rank causes of death, compare countries, and examine changes over time. From there, the results led to deeper questions about public policy, healthcare access, socioeconomic conditions, culture, and geography.

One of the biggest things I took away from the project is that data can show where something interesting is happening, but it does not always explain why.

This project allowed me to combine technical analysis with my interest in public health and use the results to guide further research into factors that may influence health outcomes across different countries.

There are still several directions the analysis could take, including population adjusted mortality rates, additional socioeconomic datasets, and more recent mortality data.

For now, the project gave me a stronger understanding of how SQL can be used to move from a large dataset to more focused questions and meaningful insights.
