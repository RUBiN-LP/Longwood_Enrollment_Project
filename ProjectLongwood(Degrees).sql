-- Create Tables For Degree Completion Records
Create Table LU_Degree(
Academic_Year VarChar(255),
Associates int,
Bachelors int,
First_Professional int,
Masters int,
Doctorate int,
Total int
);

Create Table UVA_Degree(
Academic_Year VarChar(255),
Associates int,
Bachelors int,
First_Professional int,
Masters int,
Doctorate int,
Total int
);

Create Table VCU_Degree(
Academic_Year VarChar(255),
Associates int,
Bachelors int,
First_Professional int,
Masters int,
Doctorate int,
Total int
);

-- Load Degree Data into Respective Tables
LOAD DATA LOCAL INFILE '/Users/pattersonrl/Desktop/Desktop Folders/MySQL Study/LU Enrollment Project/LU_Degree_Completions.csv'
INTO TABLE Longwood.LU_Degree
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 4 rows;

LOAD DATA LOCAL INFILE '/Users/pattersonrl/Desktop/Desktop Folders/MySQL Study/LU Enrollment Project/UVA_Degree_Completions.csv'
INTO TABLE Longwood.UVA_Degree
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 4 rows;

LOAD DATA LOCAL INFILE '/Users/pattersonrl/Desktop/Desktop Folders/MySQL Study/LU Enrollment Project/VCU_Degree_Completions.csv'
INTO TABLE Longwood.VCU_Degree
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 4 rows;

-- Show Table Results
Select * From LU_Degree;
Select * From UVA_Degree;
Select * From VCU_Degree;

-- Clear LU Table to reimport data and get rid of errors
Truncate Table LU_Degree;

-- Show New Table Data
Select * From Degree_Comparison;

-- Add Institution Column to Indivdual Tables & Insert Names
Alter Table LU_Degree
Add Institution VarChar(255);

UPDATE LU_Degree
SET Institution='LU';

Alter Table UVA_Degree
Add Institution VarChar(255);

UPDATE UVA_Degree
SET Institution='UVA';

Alter Table VCU_Degree
Add Institution VarChar(255);

UPDATE VCU_Degree
SET Institution='VCU';

-- Test Data
Select * From LU_Degree;
Select * From UVA_Degree;
Select * From VCU_Degree;

-- Create Final Blank Table To Merge All Data
Create Table Degree_Comparison(
Academic_Year VarChar(255),
Associates int,
Bachelors int,
First_Professional int,
Masters int,
Doctorate int,
Total int,
Institution VarChar(255)
);

-- Merge All Data Into New Table
INSERT IGNORE
INTO Degree_Comparison Select * From LU_Degree;

INSERT IGNORE
INTO Degree_Comparison Select * From UVA_Degree;

INSERT IGNORE
INTO Degree_Comparison Select * From VCU_Degree;

-- Show Relevant Data For Comparison
Select Academic_Year, Bachelors, First_Professional, Masters, Doctorate, Total, Institution
From Degree_Comparison
Order By 1;
