# What-Really-Drives-Early-Career-Salary-Major-or-School-Characteristics
Chennel Thompson  
ECON4970 - Data Science for Economics  
April 2026

# Project Overview 
Choosing a college major and preparing for a career are often tied to expectations about future earnings. However, it is not always clear which factors actually have the greatest influence on early-career salary outcomes. While some believe that attending a more prestigious institution leads to higher salaries, others often argue that a student's chosen field of study plays a more significant role.  

This project examines how early-career salary is associated with differences in college major and school. The goal is to better understand which factor is most strongly linked to higher starting salaries and whether common assumptions about education and earnings hold true.  

In doing so, the project examines:
* How do earnings vary across different majors?
* Do institutional characteristics such as selectivity and school type influence earnings outcomes?
* Does the relationship between SAT scores and earnings differ across majors?
  
# The Dataset
The analysis contains data from the College Scorecard (2022-2023), which includes:
- Institutional Data consisting of admission rates, average SAT scores, tuition, and school types.
- Field of Study Data consisting of major descriptions and median earnings for years after graduation.
  
# Methods
### Data Cleaning and Preparation  
The institutional and field-of-study datasets were merged using a common identifier, and relevant variables such as SAT scores, earnings, and majors were selected and renamed for clarity. Missing values and extreme earnings outliers were removed, and detailed majors were grouped into broader categories to simplify analysis.

### Descriptive Statistics  
Summary statistics were calculated for earnings and SAT scores across major categories to provide an overview of the data. These statistics help identify initial differences in outcomes by field of study before conducting further analysis.  

### Visualization & Analysis  
Visualizations, including boxplots, bar charts, and scatterplots, were used to explore patterns in the data. The lots highlight differences in earnings across majors and illustrate the relationship between SAT scores and earnings.

### Regression Analysis  
Linear regression models were estimated to examine the association between SAT scores and major choice and earnings. Interaction terms were included to assess whether the relationship between SAT scores and earnings differs across majors.
# Key Results

# Conclusion  
This project examined how college major and school characteristics are associated with early-career earnings. While both factors play a role, the results consistently show that major choice is a stronger predictor of earnings than school selectivity.

Although attending a more selective institution is associated with higher salaries, differences across majors are larger and more persistent. Students in high-paying fields such as STEM earn more regardless of the selectivity of the institution they attend.

These findings highlight the importance of your field of study in shaping early-career economic opportunities.
