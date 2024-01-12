# Charlotte and Jan's Power BI Projects

## 🌟 Introduction

Welcome to our collaborative project space where **Charlotte** and **Jan** build insightful **Power BI Dashboards**. Our journey begins with extracting publicly available data, primarily from **Eurostat** and other reliable sources. Utilizing a custom **Python API**, we efficiently upload this data into our **PostgreSQL database**. The heart of our work lies in constructing a robust datamart, facilitated by **dbt**, to power our Power BI visualizations.

## 📊 Case Studies

Explore our diverse case studies, each offering unique insights and implications.
This is still a work in progress!



### 💼 Government Expenses

#### Overview
This report examines the variation in government spending patterns across different sectors and regions in the EU. It's based on data from Eurostat: [🔗 Source](https://ec.europa.eu/eurostat/databrowser/view/gov_10a_main/default/table?lang=en). The data encompasses five key columns: 'Geopolitical reporting entity', 'Time', 'Unit of measure', 'Sector', and 'National accounts indicator (ESA 2010)'. Each column is briefly explained below, with a detailed description available [here](https://ec.europa.eu/eurostat/cache/metadata/en/gov_10a_main_esms.htm).

##### Geopolitical Reporting Entity
- Involves EU and euro area countries, Iceland, Norway, and Switzerland.

##### Time
- The time period is measured in years.

##### Unit of Measure
- Data are presented in millions of Euro, millions of national currency units, and percentages of GDP.

##### Sector
- Refers to the general government sector as defined in ESA2010.

##### National Accounts Indicator (ESA 2010)
- National accounts as defined in ESA2010.

**Elaboration on 'Sector' and 'National Accounts Indicator':**
The 'Sector' column includes data for the general government as well as its subsectors. In contrast, the 'National Accounts Indicator' column comprises various granularities, like 'Expense', 'Revenue', 'Net Lending/Borrowing', and their respective subcategories.

#### One Big Table
Here's an example table illustrating the initial dataset structure:

| Value | National Accounts Indicator (ESA 2010) | Category |
|-------|---------------------------------------|----------|
| ...   | ...                                   | ...      |

*Note: The table is truncated for brevity. Please refer to the source for complete data.*

#### Simplified Tables for Clarity
To simplify, we divide the data into tables based on granularity:

##### Expense-Revenue-Fact-Table
| Value | National Accounts Indicator (ESA 2010) | Category |
|-------|---------------------------------------|----------|
| ...   | ...                                   | ...      |

##### Expense-Fact-Table
| Value | National Accounts Indicator (ESA 2010) | Category |
|-------|---------------------------------------|----------|
| ...   | ...                                   | ...      |

##### Revenue-Fact-Table
| Value | National Accounts Indicator (ESA 2010) | Category |
|-------|---------------------------------------|----------|
| ...   | ...                                   | ...      |

*Tables are illustrative and truncated for simplicity.*


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
