# Global Energy Market Intelligence & Supply-Demand Analytics

SQL + Power BI portfolio project designed around the Rystad Energy Analyst (Data & Research) job description.

## What this project demonstrates
- Relational database design / star schema
- SQL joins, CTEs, subqueries and window functions
- Energy-market supply/demand analysis
- Year-over-year growth and market benchmarking
- Import dependency and supply-demand balance
- Power BI data model, DAX measures and interactive dashboards

## Important data note
`data/energy_market_sample.csv` is a **synthetic demonstration dataset** created for this portfolio project so the repository is immediately runnable.
For a production-style version, replace it with a public energy dataset such as the Our World in Data Energy dataset and cite the source in the final dashboard/report. The OWID dataset is worldwide and includes energy consumption, energy mix and fossil-fuel production indicators.

## Repository structure
```text
global-energy-market-intelligence/
├── data/
│   └── energy_market_sample.csv
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables_and_load.sql
│   ├── 03_create_views.sql
│   └── 04_analysis_queries.sql
├── powerbi/
│   ├── DAX_Measures.txt
│   └── Dashboard_Design.md
└── README.md
```

## SQL Server setup
1. Open SQL Server Management Studio.
2. Run `sql/01_create_database.sql`.
3. Run `sql/02_create_tables_and_load.sql`.
4. The load script creates the staging table and imports the CSV. If your CSV path is different, edit the `BULK INSERT` path.
5. Run `sql/03_create_views.sql`.
6. Run `sql/04_analysis_queries.sql`.

## Power BI setup
1. Open Power BI Desktop.
2. Get Data → SQL Server.
3. Select the `EnergyMarketDB` database.
4. Import the analytical views from `dbo`.
5. Create the DAX measures in `powerbi/DAX_Measures.txt`.
6. Build the four pages described in `powerbi/Dashboard_Design.md`.

## Suggested project story
The dashboard answers:
- Which countries are major energy producers?
- Which markets have persistent supply deficits?
- Which countries are highly import dependent?
- Which markets show the strongest demand growth?
- How do oil and gas prices change over time?
- Which markets could be considered high-priority opportunities based on demand growth and supply imbalance?

## Resume-safe project title
**Global Energy Market Intelligence & Supply-Demand Analytics | SQL, Power BI, DAX**

Do not claim that the synthetic data is real market data. If you replace it with OWID/public data, update this README and cite the source.
