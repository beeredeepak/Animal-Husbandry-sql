-- Animal Husbandry Data Analysis

CREATE TABLE Animals (
    AnimalID INT PRIMARY KEY,
    AnimalType VARCHAR(50),
    Breed VARCHAR(50),
    Birthdate DATE,
    Weight DECIMAL(10,2),
    Gender CHAR(1),
    FarmID INT,
    ParentID INT,
    SourceAnimalID INT,
    TargetAnimalID INT
);

CREATE TABLE HealthRecords (
    RecordID INT PRIMARY KEY,
    AnimalID INT,
    Date DATE,
    Illness VARCHAR(100),
    Treatment VARCHAR(100),
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

CREATE TABLE FeedRecords (
    RecordID INT PRIMARY KEY,
    AnimalID INT,
    Date DATE,
    FeedType VARCHAR(50),
    Quantity DECIMAL(10,2),
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

CREATE TABLE ProductionRecords (
    RecordID INT PRIMARY KEY,
    AnimalID INT,
    Date DATE,
    Product VARCHAR(50),  -- Milk, Egg, Meat
    Quantity DECIMAL(10,2),
    QualityRating INT,
    FarmID INT,
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID)
);

CREATE TABLE BreedingRecords (
    RecordID INT PRIMARY KEY,
    SireID INT,
    DamID INT,
    OffspringID INT,
    BreedingDate DATE,
    FarmID INT,
    FOREIGN KEY (SireID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (DamID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (OffspringID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID)
);

CREATE TABLE MilkProduction (
    RecordID INT PRIMARY KEY,
    AnimalID INT,
    Date DATE,
    MilkYield DECIMAL(10,2),
    FatContent DECIMAL(5,2),
    ProteinContent DECIMAL(5,2),
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

CREATE TABLE EggProduction (
    RecordID INT PRIMARY KEY,
    AnimalID INT,
    Date DATE,
    EggCount INT,
    EggWeight DECIMAL(10,2),
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

CREATE TABLE MeatProduction (
    RecordID INT PRIMARY KEY,
    AnimalID INT,
    SlaughterDate DATE,
    CarcassWeight DECIMAL(10,2),
    MeatYield DECIMAL(10,2),
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

CREATE TABLE GeneticData (
    AnimalID INT PRIMARY KEY,
    Genotype VARCHAR(255),
    Phenotype VARCHAR(255),
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID)
);

CREATE TABLE EnvironmentalData (
    RecordID INT PRIMARY KEY,
    Date DATE,
    Time TIME,
    Temperature DECIMAL(5,2),
    Humidity DECIMAL(5,2),
    AirQualityIndex INT
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Role VARCHAR(50),
    HourlyRate DECIMAL(10,2)
);

CREATE TABLE LaborRecords (
    RecordID INT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    HoursWorked DECIMAL(10,2),
    Task VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE InventoryItems (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2)
);

CREATE TABLE InventoryTransactions (
    TransactionID INT PRIMARY KEY,
    ItemID INT,
    Date DATE,
    Quantity INT,
    TransactionType VARCHAR(20) -- Purchase, Usage, Loss
    FOREIGN KEY (ItemID) REFERENCES InventoryItems(ItemID)
);

CREATE TABLE FinancialTransactions (
    TransactionID INT PRIMARY KEY,
    Date DATE,
    Description VARCHAR(255),
    Amount DECIMAL(10,2),
    Category VARCHAR(50), -- Income, Expense
    FarmID INT,
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID)
);

CREATE TABLE Farms (
    FarmID INT PRIMARY KEY,
    FarmName VARCHAR(50),
    Location VARCHAR(100),
    Capacity INT
);

CREATE TABLE AnimalLineage (
    LineageID INT PRIMARY KEY IDENTITY(1,1),
    AnimalID INT,
    ParentID INT,
    Generation INT,
    FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (ParentID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID)
);

CREATE TABLE DiseaseTransmission (
    TransmissionID INT PRIMARY KEY IDENTITY(1,1),
    SourceAnimalID INT,
    TargetAnimalID INT,
    Disease VARCHAR(50),
    TransmissionDate DATE,
    FarmID INT,
    FOREIGN KEY (SourceAnimalID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (TargetAnimalID) REFERENCES Animals(AnimalID),
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID)
);

-- add foreign key constraints to link tables like Animals, HealthRecords, FeedRecords, ProductionRecords, and BreedingRecords to the Farms table

ALTER TABLE Animals
ADD CONSTRAINT FK_Animals_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

ALTER TABLE HealthRecords
ADD CONSTRAINT FK_HealthRecords_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

ALTER TABLE FeedRecords
ADD CONSTRAINT FK_FeedRecords_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

ALTER TABLE ProductionRecords
ADD CONSTRAINT FK_ProductionRecords_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

ALTER TABLE BreedingRecords
ADD CONSTRAINT FK_BreedingRecords_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

-- MilkProduction
ALTER TABLE MilkProduction
ADD CONSTRAINT FK_MilkProduction_Animals
FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
ADD CONSTRAINT FK_MilkProduction_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

-- EggProduction
ALTER TABLE EggProduction
ADD CONSTRAINT FK_EggProduction_Animals
FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
ADD CONSTRAINT FK_EggProduction_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

-- MeatProduction
ALTER TABLE MeatProduction
ADD CONSTRAINT FK_MeatProduction_Animals
FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
ADD CONSTRAINT FK_MeatProduction_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

-- GeneticData
ALTER TABLE GeneticData
ADD CONSTRAINT FK_GeneticData_Animals
FOREIGN KEY (AnimalID) REFERENCES Animals(AnimalID),
ADD CONSTRAINT FK_GeneticData_Farms
FOREIGN KEY (FarmID) REFERENCES Farms(FarmID);

INSERT INTO Farms (FarmID, FarmName, Location, Capacity)
VALUES
  (1, 'Green Acres Farm', 'Ruralville', 100),
  (2, 'Sunny Meadows Farm', 'Suburbanville', 50);

INSERT INTO Animals (AnimalID, AnimalType, Breed, BirthDate, Weight, Gender, FarmID, ParentID, SourceAnimalID, TargetAnimalID)
VALUES
  (1, 'Cow', 'Holstein', '2022-01-01', 500, 'F', 1, 1, 1, 2),
  (2, 'Pig', 'Yorkshire', '2023-04-15', 100, 'M', 2, 2, 2, 4),
  (3, 'Chicken', 'Leghorn', '2023-07-01', 2, 'F', 1, 3, 3, 5);

INSERT INTO HealthRecords (RecordID, AnimalID, Date, Illness, Treatment, FarmID)
VALUES
  (1, 1, '2023-05-10', 'Mastitis', 'Antibiotics', 1),
  (2, 2, '2023-08-15', 'Swine Flu', 'Medication', 2);

INSERT INTO FeedRecords (RecordID, AnimalID, Date, FeedType, Quantity, FarmID)
VALUES
  (1, 1, '2023-11-15', 'Hay', 10, 1),
  (2, 2, '2023-11-16', 'Corn', 5, 2);

INSERT INTO ProductionRecords (RecordID, AnimalID, Date, Product, Quantity, QualityRating, FarmID)
VALUES
  (1, 1, '2023-11-15', 'Milk', 15, 9, 1);

INSERT INTO BreedingRecords (RecordID, SireID, DamID, OffspringID, BreedingDate, FarmID)
VALUES
  (1, 4, 5, 6, '2023-09-01', 1);

INSERT INTO FinancialTransactions (TransactionID, Date, Description, Amount, Category, FarmID)
VALUES
  (1, '2023-11-15', 'Sale of Milk', 1000, 'Income', 1),
  (2, '2023-11-16', 'Purchase of Feed', 500, 'Expense', 1);

INSERT INTO EnvironmentalData (RecordID, Date, Time, Temperature, Humidity, AirQualityIndex)
VALUES
  (1, '2023-11-15', '12:00:00', 25, 60, 3);

INSERT INTO Employees (EmployeeID, Name, Role, HourlyRate)
VALUES
  (1, 'John Doe', 'Farmer', 15),
  (2, 'Jane Smith', 'Veterinarian', 30);

INSERT INTO LaborRecords (RecordID, EmployeeID, Date, HoursWorked, Task, FarmID)
VALUES
  (1, 1, '2023-11-15', 8, 'Feeding Animals', 1);

INSERT INTO InventoryItems (ItemID, ItemName, Quantity, UnitPrice)
VALUES
  (1, 'Hay Bales', 50, 10),
  (2, 'Chicken Feed', 20, 8);

INSERT INTO InventoryTransactions (TransactionID, ItemID, Date, Quantity, TransactionType, FarmID)
VALUES
  (1, 1, '2023-11-15', 10, 'Usage', 1);

INSERT INTO MilkProduction (RecordID, AnimalID, Date, MilkYield, FatContent, ProteinContent, FarmID)
VALUES
  (1, 1, '2023-11-15', 20, 3.5, 3.2, 1),
  (2, 1, '2023-11-16', 18, 3.8, 3.0, 1);

INSERT INTO EggProduction (RecordID, AnimalID, Date, EggCount, EggWeight, FarmID)
VALUES
  (1, 3, '2023-11-15', 20, 55, 1),
  (2, 3, '2023-11-16', 18, 52, 1);

INSERT INTO MeatProduction (RecordID, AnimalID, SlaughterDate, CarcassWeight, MeatYield, FarmID)
VALUES
  (1, 2, '2023-12-15', 120, 80, 2);

INSERT INTO GeneticData (AnimalID, Genotype, Phenotype, FarmID)
VALUES
  (1, 'AA', 'High Milk Yield', 1),
  (2, 'BB', 'Lean Meat', 2);

INSERT INTO AnimalLineage (AnimalID, ParentID, Generation)
VALUES
    (1, NULL, 1),  -- Root ancestor
    (2, 1, 2),
    (3, 1, 2),
    (4, 2, 3),
    (5, 3, 3);

INSERT INTO DiseaseTransmission (SourceAnimalID, TargetAnimalID, Disease, TransmissionDate, FarmID)
VALUES
    (1, 2, 'Foot and Mouth Disease', '2023-11-15', 1),
    (2, 4, 'Swine Flu', '2023-12-01', 1),
    (3, 5, 'Avian Flu', '2023-10-25', 2);

-- Identifying High-Yielding Animals:

SELECT 
    AnimalID, 
    AVG(Yield) AS AverageYield, 
    RANK() OVER (ORDER BY AVG(Yield) DESC) AS YieldRank
FROM ProductionRecords
GROUP BY AnimalID;

-- Predicting Disease Outbreaks:

WITH DiseaseOutbreaks AS (
    SELECT 
        Illness, 
        COUNT(*) AS OutbreakCount
    FROM HealthRecords
    GROUP BY Illness
)
SELECT 
    a.AnimalType, 
    d.Illness, 
    d.OutbreakCount
FROM Animals a
JOIN HealthRecords hr ON a.AnimalID = hr.AnimalID
JOIN DiseaseOutbreaks d ON hr.Illness = d.Illness
ORDER BY d.OutbreakCount DESC;

-- Optimizing Feed Consumption:

WITH FeedConsumption AS (
    SELECT 
        a.AnimalID, 
        f.FeedType, 
        SUM(f.Quantity) AS TotalConsumption
    FROM Animals a
    JOIN FeedRecords f ON a.AnimalID = f.AnimalID
    GROUP BY a.AnimalID, f.FeedType
)
SELECT 
    fc.AnimalID, 
    fc.FeedType, 
    fc.TotalConsumption, 
    p.Production
FROM FeedConsumption fc
JOIN ProductionRecords p ON fc.AnimalID = p.AnimalID;

-- Analyzing Breeding Patterns:

WITH BreedingHistory AS (
    SELECT 
        AnimalID, 
        Birthdate, 
        LEAD(Birthdate) OVER (PARTITION BY AnimalID ORDER BY Birthdate) AS NextBirthdate,
        DATEDIFF(day, Birthdate, LEAD(Birthdate) OVER (PARTITION BY AnimalID ORDER BY Birthdate)) AS BreedingInterval
    FROM Animals
)
SELECT 
    AnimalID, 
    AVG(BreedingInterval) AS AverageBreedingInterval
FROM BreedingHistory
GROUP BY AnimalID;

-- Total Income
SELECT SUM(Amount) AS TotalIncome 
FROM FinancialTransactions
WHERE Category = 'Income';

-- Total Expenses
SELECT SUM(Amount) AS TotalExpenses 
FROM FinancialTransactions
WHERE Category = 'Expense';

-- Net Profit/Loss
SELECT (SELECT SUM(Amount) FROM FinancialTransactions WHERE Category = 'Income') - 
       (SELECT SUM(Amount) FROM FinancialTransactions WHERE Category = 'Expense') AS NetProfitLoss;

-- Analyzing Animal Health Trends

WITH HealthTrends AS (
    SELECT 
        a.AnimalID, 
        a.AnimalType, 
        hr.Illness, 
        COUNT(*) AS IllnessCount
    FROM Animals a
    JOIN HealthRecords hr ON a.AnimalID = hr.AnimalID
    GROUP BY a.AnimalID, a.AnimalType, hr.Illness
)
SELECT 
    ht.AnimalType, 
    ht.Illness, 
    AVG(ht.IllnessCount) AS AverageIllnessCount
FROM HealthTrends ht
GROUP BY ht.AnimalType, ht.Illness;

--  Identifying High-Performing Breeding Pairs

WITH BreedingPerformance AS (
    SELECT 
        b.SireID, 
        b.DamID, 
        COUNT(*) AS OffspringCount, 
        AVG(a.Weight) AS AverageOffspringWeight
    FROM BreedingRecords b
    JOIN Animals a ON b.OffspringID = a.AnimalID
    GROUP BY b.SireID, b.DamID
)
SELECT 
    bp.SireID, 
    bp.DamID, 
    bp.OffspringCount, 
    bp.AverageOffspringWeight
FROM BreedingPerformance bp
ORDER BY bp.AverageOffspringWeight DESC; -- or WHERE bp.AverageOffspringWeight > AVG(bp.AverageOffspringWeight);

-- Analyzing Environmental Impact on Production

SELECT 
    e.Temperature, 
    e.Humidity, 
    AVG(p.MilkYield) AS AverageMilkYield
FROM EnvironmentalData e
JOIN MilkProduction mp ON e.Date = mp.Date
JOIN Animals a ON mp.AnimalID = a.AnimalID
GROUP BY e.Temperature, e.Humidity;

-- Tracking Animal Growth and Development

SELECT 
    AnimalID, 
    BirthDate, 
    Weight, 
    LEAD(Weight) OVER (PARTITION BY AnimalID ORDER BY BirthDate) AS NextWeight,
    LEAD(Weight) OVER (PARTITION BY AnimalID ORDER BY BirthDate) - Weight AS WeightGain
FROM Animals;

-- Analyzing Health Trends Over Time

SELECT 
    AnimalID, 
    Date, 
    Illness, 
    COUNT(*) OVER (PARTITION BY AnimalID, Illness) AS IllnessCount
FROM HealthRecords;

-- Monitoring Feed Consumption Trends

SELECT 
    AnimalID, 
    Date, 
    Quantity, 
    SUM(Quantity) OVER (PARTITION BY AnimalID ORDER BY Date) AS CumulativeConsumption
FROM FeedRecords;

-- Analyzing Production Trends
SELECT 
    AnimalID, 
    Date, 
    MilkYield, 
    AVG(MilkYield) OVER (PARTITION BY AnimalID) AS AverageYield
FROM MilkProduction;

-- High performing animals

WITH AnimalPerformance AS (
    SELECT
        AnimalID,
        AVG(MilkYield) AS AverageMilkYield,
        COUNT(*) AS TotalCalvings,
        RANK() OVER (ORDER BY AVG(MilkYield) DESC) AS YieldRank,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS CalvingRank
    FROM MilkProduction
    GROUP BY AnimalID
)
SELECT *
FROM AnimalPerformance
WHERE YieldRank <= 5 OR CalvingRank <= 5;

-- Ranking Animals by Weight

SELECT
    AnimalID,
    Weight,
    RANK() OVER (ORDER BY Weight DESC) AS WeightRank,
    DENSE_RANK() OVER (ORDER BY Weight DESC) AS DenseWeightRank,
    ROW_NUMBER() OVER (ORDER BY Weight DESC) AS RowNumber
FROM Animals;

--  Tracking Weight Gain Over Time

SELECT
    AnimalID,
    Date,
    Weight,
    LAG(Weight) OVER (PARTITION BY AnimalID ORDER BY Date) AS PreviousWeight,
    Weight - LAG(Weight) OVER (PARTITION BY AnimalID ORDER BY Date) AS WeightGain
FROM WeightRecords;

--  Analyzing Animal Lineage

WITH RECURSIVE AnimalLineage AS (
    SELECT 
        AnimalID, 
        ParentID, 
        1 AS Generation
    FROM Animals
    WHERE ParentID IS NULL
    
    UNION ALL
    
    SELECT 
        a.AnimalID, 
        a.ParentID, 
        al.Generation + 1
    FROM Animals a
    JOIN AnimalLineage al ON a.ParentID = al.AnimalID
)
SELECT * FROM AnimalLineage;

-- Tracking Disease Transmission

WITH DiseaseTransmission AS (
    SELECT 
        AnimalID, 
        Illness, 
        1 AS TransmissionLevel
    FROM HealthRecords
    WHERE Illness = 'DiseaseX'  -- Starting disease
    
    UNION ALL
    
    SELECT 
        a.AnimalID, 
        a.Illness, 
        dt.TransmissionLevel + 1
    FROM HealthRecords a
    JOIN DiseaseTransmission dt ON a.AnimalID = dt.AnimalID
    WHERE a.Illness = dt.Illness
)
SELECT * FROM DiseaseTransmission;

-- Calculating Performance Metrics

SELECT 
    AnimalID,
    AVG(MilkYield) OVER (PARTITION BY AnimalID) AS AverageYield,
    STDDEV(MilkYield) OVER (PARTITION BY AnimalID) AS YieldStdDev
FROM MilkProduction;

-- Analyzing Growth Rates

SELECT 
    AnimalID, 
    Birthdate, 
    Weight, 
    LAG(Weight) OVER (PARTITION BY AnimalID ORDER BY BirthDate) AS PreviousWeight,
    (Weight - LAG(Weight) OVER (PARTITION BY AnimalID ORDER BY BirthDate)) / LAG(Weight) OVER (PARTITION BY AnimalID ORDER BY BirthDate) * 100 AS GrowthRate
FROM Animals;

--  Analyzing Disease Trends

SELECT 
    Illness, 
    COUNT(*) OVER (PARTITION BY Illness) AS TotalCases,
    SUM(CASE WHEN Treatment = 'Antibiotics' THEN 1 ELSE 0 END) OVER (PARTITION BY Illness) AS AntibioticsCases,
    SUM(CASE WHEN Treatment = 'Antibiotics' THEN 1 ELSE 0 END) OVER (PARTITION BY Illness) / COUNT(*) OVER (PARTITION BY Illness) * 100 AS AntibioticsPercentage
FROM HealthRecords;

-- Tracking Feed Consumption

SELECT 
    AnimalID, 
    Date, 
    Quantity, 
    SUM(Quantity) OVER (PARTITION BY AnimalID ORDER BY Date) AS CumulativeConsumption,
    AVG(Quantity) OVER (PARTITION BY AnimalID) AS AverageDailyConsumption
FROM FeedRecords;




