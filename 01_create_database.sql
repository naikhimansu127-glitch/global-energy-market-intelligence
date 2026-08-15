IF DB_ID('EnergyMarketDB') IS NULL
    CREATE DATABASE EnergyMarketDB;
GO

USE EnergyMarketDB;
GO

IF OBJECT_ID('dbo.FactEnergyMarket','U') IS NOT NULL DROP TABLE dbo.FactEnergyMarket;
IF OBJECT_ID('dbo.DimCountry','U') IS NOT NULL DROP TABLE dbo.DimCountry;
IF OBJECT_ID('dbo.DimDate','U') IS NOT NULL DROP TABLE dbo.DimDate;
GO

CREATE TABLE dbo.DimCountry (
    CountryID INT IDENTITY(1,1) PRIMARY KEY,
    Country NVARCHAR(100) NOT NULL UNIQUE,
    Region NVARCHAR(50) NOT NULL
);

CREATE TABLE dbo.DimDate (
    Year INT PRIMARY KEY
);

CREATE TABLE dbo.FactEnergyMarket (
    MarketID INT IDENTITY(1,1) PRIMARY KEY,
    CountryID INT NOT NULL,
    Year INT NOT NULL,
    OilProduction DECIMAL(18,2),
    OilConsumption DECIMAL(18,2),
    OilImports DECIMAL(18,2),
    OilExports DECIMAL(18,2),
    OilPriceUSD DECIMAL(18,2),
    GasProduction DECIMAL(18,2),
    GasConsumption DECIMAL(18,2),
    GasImports DECIMAL(18,2),
    GasExports DECIMAL(18,2),
    GasPriceUSD DECIMAL(18,2),
    CONSTRAINT FK_Fact_Country FOREIGN KEY (CountryID) REFERENCES dbo.DimCountry(CountryID),
    CONSTRAINT FK_Fact_Date FOREIGN KEY (Year) REFERENCES dbo.DimDate(Year),
    CONSTRAINT UQ_Fact_Country_Year UNIQUE (CountryID, Year)
);
GO
