USE EnergyMarketDB;
GO

IF OBJECT_ID('dbo.StageEnergyMarket','U') IS NOT NULL DROP TABLE dbo.StageEnergyMarket;
GO

CREATE TABLE dbo.StageEnergyMarket (
    Country NVARCHAR(100),
    Region NVARCHAR(50),
    Year INT,
    Oil_Production DECIMAL(18,2),
    Oil_Consumption DECIMAL(18,2),
    Oil_Imports DECIMAL(18,2),
    Oil_Exports DECIMAL(18,2),
    Oil_Price_USD DECIMAL(18,2),
    Gas_Production DECIMAL(18,2),
    Gas_Consumption DECIMAL(18,2),
    Gas_Imports DECIMAL(18,2),
    Gas_Exports DECIMAL(18,2),
    Gas_Price_USD DECIMAL(18,2)
);
GO

-- Change this path to the location of energy_market_sample.csv on your computer.
BULK INSERT dbo.StageEnergyMarket
FROM 'C:\YOUR_PATH\energy_market_sample.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

INSERT INTO dbo.DimCountry (Country, Region)
SELECT DISTINCT Country, Region
FROM dbo.StageEnergyMarket;

INSERT INTO dbo.DimDate (Year)
SELECT DISTINCT Year
FROM dbo.StageEnergyMarket;

INSERT INTO dbo.FactEnergyMarket (
    CountryID, Year, OilProduction, OilConsumption, OilImports, OilExports, OilPriceUSD,
    GasProduction, GasConsumption, GasImports, GasExports, GasPriceUSD
)
SELECT
    c.CountryID, s.Year,
    s.Oil_Production, s.Oil_Consumption, s.Oil_Imports, s.Oil_Exports, s.Oil_Price_USD,
    s.Gas_Production, s.Gas_Consumption, s.Gas_Imports, s.Gas_Exports, s.Gas_Price_USD
FROM dbo.StageEnergyMarket s
JOIN dbo.DimCountry c ON c.Country = s.Country;
GO
