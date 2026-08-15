````markdown
# Global Energy Market Intelligence & Supply-Demand Analytics

An end-to-end **SQL Server + Power BI** analytics project for analyzing global oil and gas markets, supply-demand balances, import dependency, production trends, and commodity prices.

---

## 📊 Dashboard Preview

> Power BI dashboard screenshots will be added after completing the dashboard.

### Executive Market Overview

![Executive Dashboard](screenshots/01_executive_overview.png)

### Country Market Intelligence

![Country Intelligence](screenshots/02_country_intelligence.png)

### Supply-Demand Analysis

![Supply Demand](screenshots/03_supply_demand.png)

### Commodity Price Intelligence

![Commodity Prices](screenshots/04_commodity_prices.png)

---

## 🎯 Project Objective

The objective of this project is to build an interactive **energy-market intelligence system** using SQL Server and Power BI.

The dashboard analyzes:

- Global oil and gas production
- Energy consumption
- Imports and exports
- Supply-demand gaps
- Import dependency
- Commodity price trends
- Country and regional performance
- Market opportunities

The project demonstrates how raw energy-market data can be transformed into structured databases, analytical SQL queries, business KPIs, and interactive Power BI dashboards.

---

## 💡 Key Business Questions

The dashboard is designed to answer the following business questions:

1. Which countries are the largest oil and gas producers?
2. Which markets have persistent supply deficits?
3. Which countries are highly dependent on energy imports?
4. Which markets show strong consumption growth?
5. How do oil and gas prices change over time?
6. Which regions have the largest supply-demand imbalances?
7. Which markets could represent potential opportunities based on demand and supply conditions?

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **SQL Server** | Database design, data storage and data analysis |
| **SQL** | Joins, CTEs, subqueries, window functions and aggregations |
| **Power BI** | Interactive dashboards and data visualization |
| **DAX** | KPIs, calculated measures and business metrics |
| **CSV / Excel** | Initial data source |

---

## 🏗️ Project Architecture

```text
Energy Market Dataset
        │
        ▼
Data Validation & Staging
        │
        ▼
SQL Server Database
        │
        ├── DimCountry
        ├── DimDate
        └── FactEnergyMarket
        │
        ▼
SQL Analytical Views
        │
        ▼
Power BI Data Model
        │
        ├── DAX Measures
        ├── KPIs
        ├── Slicers
        └── Interactive Visualizations
        │
        ▼
Energy Market Intelligence Dashboard
````

---

## 🗄️ Database Design

The project uses a relational database with a star-schema approach.

### Dimension Tables

#### DimCountry

```text
DimCountry
-----------
CountryID
Country
Region
```

#### DimDate

```text
DimDate
-------
Year
```

### Fact Table

#### FactEnergyMarket

```text
FactEnergyMarket
----------------
MarketID
CountryID
Year
OilProduction
OilConsumption
OilImports
OilExports
OilPriceUSD
GasProduction
GasConsumption
GasImports
GasExports
GasPriceUSD
```

The fact table stores the main energy-market observations, while dimension tables provide country and time-based analysis.

---

## 🔎 SQL Analysis

The project demonstrates advanced SQL techniques including:

* INNER JOIN
* GROUP BY
* CASE statements
* Common Table Expressions (CTEs)
* Subqueries
* Window functions
* `LAG()`
* Year-over-year analysis
* Ranking
* Aggregation
* Supply-demand calculations
* Import dependency analysis

### Example: Year-over-Year Production Growth

```sql
WITH x AS (
    SELECT
        Country,
        Year,
        OilProduction,
        LAG(OilProduction)
        OVER (
            PARTITION BY Country
            ORDER BY Year
        ) AS PreviousYear
    FROM dbo.vw_EnergyMarketAnalysis
)

SELECT
    Country,
    Year,
    OilProduction,
    PreviousYear,
    ROUND(
        (OilProduction - PreviousYear)
        * 100.0 / NULLIF(PreviousYear, 0),
        2
    ) AS YoY_Growth
FROM x
WHERE PreviousYear IS NOT NULL
ORDER BY Country, Year;
```

This query calculates year-over-year oil production growth for each country using the SQL `LAG()` window function.

---

## 📈 Power BI Dashboard

The Power BI report contains four analytical pages.

---

### 1️⃣ Executive Market Overview

The executive dashboard provides a high-level overview of global energy markets.

#### Key Performance Indicators

* Total Oil Production
* Total Oil Consumption
* Total Gas Production
* Total Gas Consumption
* Oil Supply-Demand Gap
* Oil Import Dependency

#### Visualizations

* Global oil supply vs demand trend
* Top 10 oil-producing countries
* Global production map
* Regional energy comparison
* Year and country filters

---

### 2️⃣ Country Market Intelligence

The country-level dashboard provides detailed market analysis for individual countries.

Users can select a country using an interactive slicer.

#### Metrics

* Oil Production
* Oil Consumption
* Oil Imports
* Oil Exports
* Supply-Demand Gap
* Import Dependency
* Oil Price
* Gas Price

#### Visualizations

* Production vs consumption trend
* Import dependency trend
* Energy production mix
* Commodity price trend
* Country-level KPIs

---

### 3️⃣ Supply-Demand Analysis

This dashboard focuses on identifying supply and demand imbalances across markets.

#### Analysis

* Supply-surplus markets
* Supply-deficit markets
* Import-dependent countries
* Regional supply-demand differences
* Market balance trends

Markets are classified into:

```text
Supply Surplus
Supply Deficit
Balanced
```

#### Key Visualizations

* Supply-demand gap by country
* Top import-dependent markets
* Supply surplus vs deficit distribution
* Regional market comparison
* Historical supply-demand trends

---

### 4️⃣ Commodity Price Intelligence

This dashboard analyzes historical oil and gas price movements.

#### Analysis

* Oil price trends
* Gas price trends
* Production vs price relationship
* Country-level commodity performance
* Historical price movements

#### Visualizations

* Global oil price trend
* Global gas price trend
* Oil price vs production scatter plot
* Country and regional filters

---

## 📐 DAX Measures

The dashboard uses DAX measures to create dynamic KPIs and analytical metrics.

### Total Oil Production

```DAX
Total Oil Production =
SUM(vw_EnergyMarketAnalysis[OilProduction])
```

### Total Oil Consumption

```DAX
Total Oil Consumption =
SUM(vw_EnergyMarketAnalysis[OilConsumption])
```

### Total Gas Production

```DAX
Total Gas Production =
SUM(vw_EnergyMarketAnalysis[GasProduction])
```

### Total Gas Consumption

```DAX
Total Gas Consumption =
SUM(vw_EnergyMarketAnalysis[GasConsumption])
```

### Oil Supply-Demand Gap

```DAX
Oil Supply-Demand Gap =
[Total Oil Production] - [Total Oil Consumption]
```

### Gas Supply-Demand Gap

```DAX
Gas Supply-Demand Gap =
[Total Gas Production] - [Total Gas Consumption]
```

### Oil Import Dependency

```DAX
Oil Import Dependency % =
DIVIDE(
    SUM(vw_EnergyMarketAnalysis[OilImports]),
    [Total Oil Consumption],
    0
)
```

### Average Oil Price

```DAX
Average Oil Price =
AVERAGE(vw_EnergyMarketAnalysis[OilPriceUSD])
```

### Average Gas Price

```DAX
Average Gas Price =
AVERAGE(vw_EnergyMarketAnalysis[GasPriceUSD])
```

### Oil Production Year-over-Year Growth

```DAX
Oil Production YoY % =
VAR CurrentYear =
    MAX(vw_EnergyMarketAnalysis[Year])

VAR CurrentProduction =
    CALCULATE(
        [Total Oil Production],
        vw_EnergyMarketAnalysis[Year] = CurrentYear
    )

VAR PreviousProduction =
    CALCULATE(
        [Total Oil Production],
        FILTER(
            ALL(vw_EnergyMarketAnalysis[Year]),
            vw_EnergyMarketAnalysis[Year] = CurrentYear - 1
        )
    )

RETURN
DIVIDE(
    CurrentProduction - PreviousProduction,
    PreviousProduction,
    0
)
```

---

## 📊 Market Classification

Markets are classified using the oil supply-demand balance.

```text
Oil Supply-Demand Gap =
Oil Production - Oil Consumption
```

Classification:

```text
Positive Gap  → Supply Surplus
Negative Gap  → Supply Deficit
Zero Gap      → Balanced
```

This classification helps identify markets with potential supply constraints or surplus conditions.

---

## 📁 Repository Structure

```text
global-energy-market-intelligence/
│
├── data/
│   ├── energy_market_sample.csv
│   └── DATA_DICTIONARY.md
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables_and_load.sql
│   ├── 03_create_views.sql
│   └── 04_analysis_queries.sql
│
├── powerbi/
│   ├── DAX_Measures.txt
│   └── Dashboard_Design.md
│
├── screenshots/
│   ├── 01_executive_overview.png
│   ├── 02_country_intelligence.png
│   ├── 03_supply_demand.png
│   └── 04_commodity_prices.png
│
└── README.md
```

---

## ⚙️ How to Run the Project

### SQL Server Setup

1. Install SQL Server and SQL Server Management Studio.
2. Open SQL Server Management Studio.
3. Run:

```text
sql/01_create_database.sql
```

4. Update the CSV file path inside:

```text
sql/02_create_tables_and_load.sql
```

5. Run:

```text
sql/02_create_tables_and_load.sql
```

6. Run:

```text
sql/03_create_views.sql
```

7. Run:

```text
sql/04_analysis_queries.sql
```

8. Verify the analytical view:

```sql
SELECT TOP 10 *
FROM dbo.vw_EnergyMarketAnalysis;
```

---

## 🔗 Power BI Connection

1. Open Power BI Desktop.
2. Select:

```text
Home → Get Data → SQL Server
```

3. Enter the SQL Server instance.
4. Select the database:

```text
EnergyMarketDB
```

5. Select:

```text
dbo.vw_EnergyMarketAnalysis
```

6. Choose **Import**.
7. Load the data into Power BI.
8. Create the DAX measures.
9. Build the four dashboard pages.
10. Add interactive slicers and visualizations.

---

## 📸 Dashboard Screenshots

After completing the Power BI dashboard, add the following screenshots to the `screenshots` folder:

### Screenshot 1

```text
01_executive_overview.png
```

Should show:

* KPI cards
* Global supply-demand trend
* Top 10 producers
* Global map

### Screenshot 2

```text
02_country_intelligence.png
```

Select a country such as India and show:

* Production
* Consumption
* Imports
* Exports
* Supply-demand gap
* Import dependency
* Price trend

### Screenshot 3

```text
03_supply_demand.png
```

Show:

* Supply-deficit markets
* Supply-surplus markets
* Import dependency
* Regional comparison

### Screenshot 4

```text
04_commodity_prices.png
```

Show:

* Oil price trend
* Gas price trend
* Production vs price analysis

---

## 📌 Key Insights

The dashboard can be used to identify:

* Major energy-producing markets
* High-consumption markets
* Supply-deficit countries
* Supply-surplus countries
* Import-dependent markets
* Regional energy trends
* Commodity price movements
* Changes in production and consumption over time

---

## 🚀 Future Improvements

Potential improvements to the project include:

* Replace synthetic data with real public energy datasets
* Automate data ingestion using Python
* Add monthly energy-market data
* Add renewable-energy indicators
* Add carbon-emission analysis
* Add machine-learning forecasting
* Add automated data-quality validation
* Add Power BI forecasting
* Add market-opportunity scoring
* Deploy the dashboard using Power BI Service
* Automate the SQL data pipeline

---

## ⚠️ Data Disclaimer

The current repository contains a **synthetic demonstration dataset** created for portfolio and learning purposes.

The data should **not be interpreted as official energy-market statistics or Rystad Energy data**.

For a production-style extension, the dataset can be replaced with a publicly available energy dataset such as the **Our World in Data Energy dataset**, with appropriate source attribution.

---

## 🎓 Skills Demonstrated

**SQL | SQL Server | Database Design | Data Modeling | Power BI | DAX | Data Visualization | Business Intelligence | Energy Market Analytics | Supply-Demand Analysis | Market Research**

---

## 👨‍💻 Author

### Himansu Naik

GitHub:
https://github.com/naikhimansu127-glitch

---

## ⭐ Project Highlights

This project demonstrates an end-to-end analytics workflow:

```text
Data
 ↓
SQL Database
 ↓
Data Modeling
 ↓
SQL Analysis
 ↓
DAX
 ↓
Power BI
 ↓
Business Insights
```

The project focuses on transforming structured energy-market data into actionable analytical insights through SQL and interactive business intelligence dashboards.

```
```
