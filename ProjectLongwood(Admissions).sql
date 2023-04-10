-- Create Project Database
Create Database Longwood;

-- Create Admissions Tables To House Data
Create Table LU_Admission(
Institution VarChar(255),
Year VarChar(255),
Domicile VarChar(255),
Applied int,
Accepted int,
Acceptance Decimal(3,3),
Enrolled int,
Yield_Rate Decimal(3,3),
Rejected int,
Rejection_Rate Decimal(3,3)
);

Create Table UVA_Admissions(
Institution VarChar(255),
Year VarChar(255),
Domicile VarChar(255),
Applied int,
Accepted int,
Acceptance Decimal(3,3),
Enrolled int,
Yield_Rate Decimal(3,3),
Rejected int,
Rejection_Rate Decimal(3,3)
);

Create Table VCU_Admissions(
Institution VarChar(255),
Year VarChar(255),
Domicile VarChar(255),
Applied int,
Accepted int,
Acceptance Decimal(3,3),
Enrolled int,
Yield_Rate Decimal(3,3),
Rejected int,
Rejection_Rate Decimal(3,3)
);

-- Load Admissions Data into Respective Tables
LOAD DATA LOCAL INFILE '/Users/pattersonrl/Desktop/Desktop Folders/MySQL Study/LU Enrollment Project/LU_Admissions_Report.csv'
INTO TABLE Longwood.LU_Admission
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 3 rows;

LOAD DATA LOCAL INFILE '/Users/pattersonrl/Desktop/Desktop Folders/MySQL Study/LU Enrollment Project/UVA_Admissions_Report.csv'
INTO TABLE Longwood.UVA_Admissions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 3 rows;

LOAD DATA LOCAL INFILE '/Users/pattersonrl/Desktop/Desktop Folders/MySQL Study/LU Enrollment Project/VCU_Admissions_Report.csv'
INTO TABLE Longwood.VCU_Admissions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 3 rows;

-- Add an 's' to LU_Admission Table Name
Alter Table LU_Admission
Rename To LU_Admissions;

-- Show Complete Table Outputs
Select * From LU_Admissions;
Select * From UVA_Admissions;
Select * From VCU_Admissions;

-- Create Final Blank Table To Merge All Data
Create Table Admissions_Comparison(
Institution VarChar(255),
Year VarChar(255),
Domicile VarChar(255),
Applied int,
Accepted int,
Acceptance Decimal(3,3),
Enrolled int,
Yield_Rate Decimal(3,3),
Rejected int,
Rejection_Rate Decimal(3,3)
);

-- Merge All Data Into New Table
INSERT IGNORE
INTO Admissions_Comparison Select * From LU_Admissions;

INSERT IGNORE
INTO Admissions_Comparison Select * From UVA_Admissions;

INSERT IGNORE
INTO Admissions_Comparison Select * From VCU_Admissions;

-- Show New Table Data
Select * From Admissions_Comparison;

-- Fix Column Name
Alter Table Admissions_Comparison
RENAME Column Acceptance To Acceptance_Rate;

-- Show Relevant Data For Comparison
Select Institution, Year, Applied, Accepted, Acceptance_Rate*100 as Acceptance_Rate, Enrolled, Yield_Rate*100 as Yield_Rate, Rejected, Rejection_Rate*100 as Yield_Rate
FROM Admissions_Comparison
Order By 2;

Select Institution, Year, Applied, Accepted, Enrolled
FROM Admissions_Comparison
Order By 2;