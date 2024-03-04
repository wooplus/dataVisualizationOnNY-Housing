NY Dataset Kaggle Link -- https://www.kaggle.com/datasets/nelgiriyewithana/new-york-housing-market

-- Database Setup

-- !!Go to mysqlsh script directory and run the mysql script file 

cd /usr/local/bin
./mysqlsh

-- !!Switch into SQL mode by using \sql and Create the schema and tables 

\sql

-- !!Connect to the database server hosted on the Google Cloud on mysql local shell
\c --mysql --user=root --host=34.75.9.212 

-- !!Create the Database, schema and tables
CREATE DATABASE `final-aung`
USE `final-aung`

CREATE TABLE `final-aung`.`NYHouse` (
    `BrokerTitle` varchar(255), 
    `Type` varchar(255),
    `Price` INT,
    `Beds` TINYINT,
    `Bath` TINYINT,
    `PropertySqft` DECIMAL(11,6),
    `Address` varchar(255),
    `State` varchar(255), 
    `MainAddress` varchar(255),
    `AdministrativeAreaLevel2` varchar(128), 
    `Locality` varchar(128),
    `SubLocality` varchar(128),
    `StreetName` varchar(128),
    `LongName` varchar(128),
    `FormattedAddress` varchar(255),
    `Latitude` DECIMAL(11, 8),
    `Longitude` DECIMAL(11,8)
);

-- !! change to Javascript Mode
\js


-- !! Import the data from a comma separated values file (csv) JS Mode 
util.importTable("/Users/bryan/Desktop/ThirdSemestersCourses/MAC250-Database/NY-House-Dataset.csv" , {
    "schema": "final-aung",
    "table": "NYHouse",
    "dialect": "csv-unix",
    "skipRows": 1,
    "showProgress": true
})


-- What is the average price of the house in New York ?
SELECT AVG(price) FROM `NYHouse`;

-- What is the average square feet of the house in New York ?
SELECT AVG(PropertySqft) FROM `NYHouse`;

-- Number of broker companies analyzed ?
SELECT count(DISTINCT `BrokerTitle`) AS `COUNT_DISTINCT(BrokerTitle)`
FROM `final-aung`.`NYHouse`

-- Average bathroom and bedroom in NY House?
SELECT AVG(Beds) AS AVERAGEBED, AVG(Bath) AS AVERAGEBATH FROM NYHouse;

-- Average Number of Bedrooms and bathrooms based on the housing type?
SELECT Type,AVG(Beds), AVG(Bath) FROM NYHouse GROUP BY Type; 

-- Who are the ten top performing brokers ?
SELECT BrokerTitle,COUNT(*) FROM NYHouse GROUP BY BrokerTitle ORDER BY COUNT(*) DESC LIMIT 10;

-- Count of Top  Ten Housing Types Analyzed in descending order ?
SELECT Type,COUNT(*) FROM NYHouse GROUP BY Type ORDER BY COUNT(*) DESC LIMIT 10;


-- Which SubLocality has the highest price ?
SELECT SubLocality, AVG(Price) AS AveragePrice, COUNT(SubLocality) AS NumberOfProperties, AVG(PropertySqft) AS AveragePropertySqft FROM NYHouse GROUP BY SubLocality ORDER BY AVG(Price) DESC;

-- Compare the price and property sq ft in different sublocalities. 
SELECT SubLocality, AVG(Price) AS AveragePrice, COUNT(SubLocality) AS NumberOfProperties, AVG(PropertySqft) AS AveragePropertySqft FROM NYHouse GROUP BY SubLocality ORDER BY AveragePropertySqft DESC;

-- Which property type has the highest price in New York? aka List of the average price of the house based on their property type
SELECT Type, AVG(Price) AS AveragePrice, COUNT(SubLocality) AS NumberOfProperties, AVG(PropertySqft) AS AveragePropertySqft FROM NYHouse GROUP BY Type Order By AveragePrice DESC;

-- Which property type has the highest price filtered on major 7 types?
SELECT 
    CASE 
        WHEN Type LIKE '%Condo%' THEN 'Condo'
        WHEN Type LIKE '%House%' THEN 'House'
        WHEN Type LIKE '%Townhouse%' THEN 'Townhouse'
        WHEN Type LIKE '%Co-op%' THEN 'Co-op'
        WHEN Type LIKE '%Land%' THEN 'Land'
        WHEN Type LIKE '%Condop%' THEN 'Condop'
        WHEN Type LIKE '%Multi-Family%' THEN 'Multi-family Home'
        ELSE 'Other'
    END AS PropertyType,
    AVG(Price) AS AveragePrice,
    COUNT(*) AS NumberOfProperties,
    AVG(PropertySqft) AS AveragePropertySqft
FROM 
    NYHouse
GROUP BY 
    PropertyType
ORDER BY 
    AveragePrice;



-- SQL Procedures

DELIMITER | 
CREATE PROCEDURE getHousingListAndAveragePrice()
BEGIN 
    SELECT * FROM NYHouse;
    SELECT AVG(Price) FROM NYHouse;
END |


CALL getHousingListAndAveragePrice();


DELIMITER | 
CREATE PROCEDURE getHousingOnSubLocality (param VARCHAR(128))
BEGIN 
    SELECT BrokerTitle, Type, Price, PropertySqft FROM NYHouse
    WHERE SubLocality LIKE param
    ORDER BY Price DESC
    ;
END |

-- Testing with Top 5 Boroughs of New York City 
CALL getHousingOnSubLocality('%Brooklyn%');
CALL getHousingOnSubLocality('%Bronx%');
CALL getHousingOnSubLocality('%Queens%');
CALL getHousingOnSubLocality('%Manhattan%');
CALL getHousingOnSubLocality('%Staten Island%');

DELIMITER | 
CREATE PROCEDURE getAveragePriceOfPropertyType(param VARCHAR(255))
BEGIN 
    SELECT Type, AVG(Price) FROM NYHouse
    WHERE Type LIKE param
    GROUP BY Type;
END |

-- Testing with demanding property type
CALL getAveragePriceOfPropertyType('%condo%'); -- generate average price of condo and condop
CALL getAveragePriceOfPropertyType('%family%');
CALL getAveragePriceOfPropertyType('%house%'); -- generate average price of house, mobile house and town house
CALL getAveragePriceOfPropertyType('%land%');

SHOW PROCEDURE STATUS WHERE Db='final-aung'; -- show the procedures created

-- Create a view for viewing NYHousing data
CREATE VIEW NYHousingView AS 
SELECT 'mysql' dbms,t.TABLE_SCHEMA,t.TABLE_NAME,c.COLUMN_NAME,c.ORDINAL_POSITION,c.DATA_TYPE,c.CHARACTER_MAXIMUM_LENGTH,n.CONSTRAINT_TYPE,k.REFERENCED_TABLE_SCHEMA,k.REFERENCED_TABLE_NAME,k.REFERENCED_COLUMN_NAME FROM INFORMATION_SCHEMA.TABLES t LEFT JOIN INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_SCHEMA=c.TABLE_SCHEMA AND t.TABLE_NAME=c.TABLE_NAME LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE k ON c.TABLE_SCHEMA=k.TABLE_SCHEMA AND c.TABLE_NAME=k.TABLE_NAME AND c.COLUMN_NAME=k.COLUMN_NAME LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS n ON k.CONSTRAINT_SCHEMA=n.CONSTRAINT_SCHEMA AND k.CONSTRAINT_NAME=n.CONSTRAINT_NAME AND k.TABLE_SCHEMA=n.TABLE_SCHEMA AND k.TABLE_NAME=n.TABLE_NAME WHERE t.TABLE_TYPE='BASE TABLE' AND t.TABLE_SCHEMA NOT IN('INFORMATION_SCHEMA','mysql','performance_schema');

-- Create a view for showing table data structure

CREATE VIEW NYDataStructureView AS 
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'NYHouse';

Database Backup

-- Create a directory to store the backup in bin directory
sudo mkdir -p /usr/local/bin/NYHouse
sudo chown -R bryan:staff /usr/local/bin/NYHouse

util.dumpSchemas(["final-aung"], "NYHouse", {"compression": "none", "threads": 6, chunking: false})

-- Store another backup in final project directory
util.dumpSchemas(["final-aung"], "/Users/bryan/Desktop/ThirdSemestersCourses/MAC250-Database/finalProjectAssignment/NYHouse", {"compression": "none", "threads": 6, chunking: false})
