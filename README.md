# data-merging
Collect and merge data from public datasets, indexes, and Wikipedia pages to analyze with linear models.

### Table of Contents
* Introduction
* Technologies
* Libraries/Packages
* Method
* External Links 

### Introduction
This project was a university assignment with the purpose of recreating the results from Howard and Roesseler’s 2009 article “Post-Cold War Political Regimes: When Do Elections Matter?”  I was randomly assigned 10 authoritarian regimes from 1995-2005 to analyze for this project, but this can be replicated with any number of regimes/years. 
The files GLManalysis.docx and LManalysis.docx include an explanation of the dependent and independent variables used to replicate Howard and Roessler’s analysis and breakdown the linear models.  These files contain visualizations and tables of the results with an explanation of my findings. 

### Technologies
* Python 3.8
* R 4.0

### Libraries/Packages
Python: 
* Requests
* Beautiful Soup
* Pandas

R:  
* dplyr
* readstata13
* ggplot2
*	binaryLogic

### Method
wikiscrape.py uses the requests module in Python to access wikipedia pages for the countries’ general election results in the predetermined time.  Using Beautiful Soup, parse the page for the word “coalition” which is coded to a binary variable if the word is found or not.  The output is “coalition.csv” in which each line is a country name, year, and binary value for coalition.

data_merge.R uses the Varieties of Democracy dataset, World Democracy Index, Database of Political Institutions, and Mass Mobilization Protest Data to complete the dataset needed for my analysis.  Once the data frames are subsetted to only include the countries and years specific to this project, the required features are selected and re-coded as necessary. The final result of this file is the merged dataset “first_merge.csv” of features from the datasets mentioned above. 

merge_LM.R takes “first_merge.csv” and “coalition.csv” and merges them into “final_dataset.csv” before fitting a linear model. generalizedLM.R uses the “final_dataset.csv” to conduct generalized linear models, odds ratios, improvements of the linear model and visualizations of the results. 

### External Links
Howard Roessler 2009: Post-Cold War Political Regimes: When Do Elections Matter? 
https://roesslerphilip.files.wordpress.com/2015/08/roessler-and-howard_post-cold-war-political-regimes_2009.pdf 

Varieties of Democracy Version 9
https://www.v-dem.net/ 

WDI
https://cran.r-project.org/web/packages/WDI/WDI.pdf

DPI
https://publications.iadb.org/en/database-political-institutions-2020-dpi2020

Mass Mobilization
https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/HTTWYL
