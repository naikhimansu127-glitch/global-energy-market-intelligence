USE EnergyMarketDB;
GO

-- 1. Country-level market overview
SELECT Country, Region,
       SUM(OilProduction) AS TotalOilProduction,
       SUM(OilConsumption) AS TotalOilConsumption,
       SUM(GasProduction) AS TotalGasProduction,
       SUM(GasConsumption) AS TotalGasConsumption
FROM dbo.vw_EnergyMarketAnalysis
GROUP BY Country, Region
ORDER BY TotalOilProduction DESC;
GO

-- 2. Year-over-year oil production growth
WITH x AS (
    SELECT Country, Year, OilProduction,
           LAG(OilProduction) OVER(PARTITION BY Country ORDER BY Year) AS PreviousYear
    FROM dbo.vw_EnergyMarketAnalysis
)
SELECT Country, Year, OilProduction, PreviousYear,
       ROUND((OilProduction - PreviousYear) * 100.0 / NULLIF(PreviousYear,0),2) AS YoY_OilProductionGrowthPct
FROM x
WHERE PreviousYear IS NOT NULL
ORDER BY Country, Year;
GO

-- 3. Top supply-deficit oil markets
SELECT TOP 10 Country, Year, OilSupplyDemandGap
FROM dbo.vw_EnergyMarketAnalysis
ORDER BY OilSupplyDemandGap ASC;
GO

-- 4. Most import-dependent oil markets
SELECT Country,
       ROUND(AVG(OilImportDependencyPct),2) AS AvgOilImportDependencyPct
FROM dbo.vw_EnergyMarketAnalysis
GROUP BY Country
ORDER BY AvgOilImportDependencyPct DESC;
GO

-- 5. Regional performance
SELECT Region,
       AVG(OilProduction) AS AvgOilProduction,
       AVG(OilConsumption) AS AvgOilConsumption,
       AVG(GasProduction) AS AvgGasProduction,
       AVG(GasConsumption) AS AvgGasConsumption
FROM dbo.vw_EnergyMarketAnalysis
GROUP BY Region
ORDER BY AvgOilProduction DESC;
GO

-- 6. Market classification
SELECT Country, Year,
       OilSupplyDemandGap,
       CASE
           WHEN OilSupplyDemandGap > 0 THEN 'Supply Surplus'
           WHEN OilSupplyDemandGap < 0 THEN 'Supply Deficit'
           ELSE 'Balanced'
       END AS OilMarketStatus
FROM dbo.vw_EnergyMarketAnalysis;
GO
