# Charlotte and Jan's Power BI Projects

## 🌟 Introduction

Welcome to our collaborative project space where **Charlotte** and **Jan** build insightful **Power BI Dashboards**. Our journey begins with extracting publicly available data, primarily from **Eurostat** and other reliable sources. Utilizing a custom **Python API**, we efficiently upload this data into our **PostgreSQL database**. The heart of our work lies in constructing a robust datamart, facilitated by **dbt**, to power our Power BI visualizations.

## 📊 Case Studies

Explore our diverse case studies, each offering unique insights and implications.
This is still a work in progress!



### 💼 Government Expenses

#### Overview
Examining how government spending patterns vary across different sectors and regions in the EU. The report is based on data provided by eurostat:
[🔗 Source](https://ec.europa.eu/eurostat/databrowser/view/gov_10a_main/default/table?lang=en)
This data has 5 columns of interest: 'Geopolitical reporting entity', 'Time', 'Unit of measure', 'Sector' and 'National accounts indicator (ESA 2010)'. I will briefly explain each column and its implications as to data modelling. A more detailled explanation can be found here: https://ec.europa.eu/eurostat/cache/metadata/en/gov_10a_main_esms.htm

##### Geopolitical reporting entity
- EU and euro area countries, Iceland, Norway and Switzerland.

##### Time
- time period in years

##### Unit of measure
- Data are presented in millions of Euro, millions of national currency units and percentages of GDP.

##### Sector
- General government sector as defined in ESA2010

##### National accounts indicator (ESA 2010)
- national accountsas defined in ESA2010

Althoug most columns should be self-explanatory it is worth elaborting on the columns sector and national accounts indicator. Let's look at the statistical concepts in the metadata document:
'The indicators are compiled on a national accounts (ESA 2010) basis. They comprise main aggregates (total revenue and expenditure, main components (ESA 2010 economic categories as well as balancing items) for the general government sector and its subsectors (central, state, local government and social security funds) The difference between total revenue and total expenditure equals net lending/net borrowing (B.9).'

This means that the column sector contains data for the general government as well as its subsectors meaning that the sum of the subcategories should equal the value of the genral government. Additionally, the sectors also take into account the difference between federal and central governments. To keep the model as simple as possible and ensure that different countries can be compared accordingly, we will only look at the sector 'General Government'.
However, this approach does not work for the column 'National Accounts Indicator'. For instance, this column contains the values: 'Expense', 'Revenue', 'Net Lending/Borrowing' as well as the subcategories for 'Expense' and 'Revenue'. This means that we face a fact table that contains data of different granularities. Here is an example (I have added the column Category just for clarification, it is not part of the initial dataset)

## One Big Table

| Value | National accounts indicator (ESA 2010)  | Category |
| :------------ |:---------------:| -----:|
| 1    | Expense| Total |
| 2     | Revenue        | Total|
| 3| Net Borrowing/Lending       | Total|
| 1    | Compensation of employees, payable| Expense |
| 2     | Subsidies, payable        | Expense |
| 3| Interest, payable     | Expense |
| 1    | Social benefits other than social transfers in kind and social transfers in kind ? purchased market production, payable| Expense |
| 2     | Capital transfers, payable        | Expense |
| 3| Gross capital formation and acquisitions less disposals of non-financial non-produced assets     | Expense |
| 3| Intermediate consumption    | Expense |
| 1    | Taxes on production and imports, receivable| Revenue |
| 2     | Current taxes on income, wealth, etc., receivable    | Revenue |
| 3| Net social contributions, receivable    | Revenue|
| 1    | Capital taxes, receivable| Revenue|
| 2     | Other capital transfers and investment grants, receivable     |Revenue |
| 3| Market output, output for own final use and payments for non-market output   | Revenue||


As we can see, the initial fact table contains data for total expenses as well as for its subcategories, such as Subsidies. This is just a simple example since the model contains almost 120 indicators and e.g. the indicator subsidies will be split up further.
However, for this reason we will build one table for each granularity so that the initial table will be simplified like this:

## Expense-Revenue-Fact-Table

| Value | National accounts indicator (ESA 2010)  | Category |
| :------------ |:---------------:| -----:|
| 1    | Expense| Total |
| 2     | Revenue        | Total |
| 3| Net Borrowing/Lending       | Total|

## Expense-Fact-Table

| Value | National accounts indicator (ESA 2010)  | Category |
| :------------ |:---------------:| -----:|
| 1    | Compensation of employees, payable| Expense |
| 2     | Subsidies, payable        | Expense |
| 3| Interest, payable     | Expense |
| 1    | Social benefits other than social transfers in kind and social transfers in kind ? purchased market production, payable| Expense |
| 2     | Capital transfers, payable        | Expense |
| 3| Gross capital formation and acquisitions less disposals of non-financial non-produced assets     | Expense |
| 3| Intermediate consumption    | Expense |

## Revenue-Fact-Table

| Value | National accounts indicator (ESA 2010)  | Category |
| :------------ |:---------------:| -----:|
| 1    | Taxes on production and imports, receivable| Revenue |
| 2     | Current taxes on income, wealth, etc., receivable    | Revenue |
| 3| Net social contributions, receivable    | Revenue|
| 1    | Capital taxes, receivable| Revenue|
| 2     | Other capital transfers and investment grants, receivable     |Revenue |
| 3| Market output, output for own final use and payments for non-market output   | Revenue|

#### Data Model
...

#### Findings
...

#### Conclusion
...

[🔗 View Government Expenses Report](https://app.powerbi.com/view?r=eyJrIjoiZjU2Y2VjZDktNmUyNC00NjFiLWFkNzYtYmE1YTU0NmY1MGQ1IiwidCI6IjI5ODAzN2JlLTdhZDgtNGM4My04MGYzLTRmMDQ1NGEwY2ZjZCJ9)

### 👥 Demographics

#### Overview
A comprehensive examination of demographic shifts and trends within the European Union.

#### Data Model
...

#### Findings
...

#### Conclusion
...

[🔗 View Demographics Report](https://link-to-demographics-report)

### 💔 Divorce Rate

#### Overview
Studying the changing patterns of divorce rates across the EU, and the underlying factors.

#### Data Model
...

#### Findings
...

#### Conclusion
...

[🔗 View Divorce Rate Report](https://link-to-divorce-rate-report)

## 🚀 Getting Started

To delve into our data and analysis, explore the Power BI dashboards linked above. The datasets and scripts used in these studies are also available in this repository.

### 📁 Repository Structure

- `Power BI/`: Contains Power BI reports and datasets for each case study.
- `etl/`: Hosts ETL scripts, dbt project for data transformation, and README for setup and usage instructions.

For further details on each component, refer to the README files within the respective directories.
