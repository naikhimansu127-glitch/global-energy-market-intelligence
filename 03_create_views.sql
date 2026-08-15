USE EnergyMarketDB;
GO

CREATE OR ALTER VIEW dbo.vw_EnergyMarketAnalysis AS
SELECT
    f.MarketID,
    c.Country,
    c.Region,
    f.Year,
    f.OilProduction,
    f.OilConsumption,
    f.OilImports,
    f.OilExports,
    f.OilPriceUSD,
    f.GasProduction,
    f.GasConsumption,
    f.GasImports,
    f.GasExports,
    f.GasPriceUSD,
    f.OilProduction - f.OilConsumption AS OilSupplyDemandGap,
    f.GasProduction - f.GasConsumption AS GasSupplyDemandGap,
    CASE
        WHEN f.OilConsumption = 0 THEN 0
        ELSE (f.OilImports / f.OilConsumption) * 100
    END AS OilImportDependencyPct,
    CASE
        WHEN f.GasConsumption = 0 THEN 0
        ELSE (f.GasImports / f.GasConsumption) * 100
    END AS GasImportDependencyPct
FROM dbo.FactEnergyMarket f
JOIN dbo.DimCountry c ON f.CountryID = c.CountryID;
GO
