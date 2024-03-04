NY Dataset Kaggle Link -- https://www.kaggle.com/datasets/nelgiriyewithana/new-york-housing-market

-- Set up Apache Superset VM on Google Cloud Compute Engine

-- create VM in google cloud using scripts
-- Create the apache superset compute engine vm.

gcloud compute instances create superset \
 --image-family ubuntu-2004-lts \
 --image-project ubuntu-os-cloud \
 --machine-type n1-standard-1 \
 --description superset \
 --zone us-east1-c \
 --tags http-server \
 --metadata=startup-script='#!/bin/bash
curl -sSL https://storage.googleapis.com/jose-bucket-mac250/script.sh | bash'

-- click connect SSH

sudo systemctl status superset <-- Check superset is running or not

sudo systemctl enable superset

-- Connect Apache Superset to MySQL Cloud SQL instance

IP Address = Database Instance IP Address 34.75.9.212
Database Name = final-aung
PORT = 3306
Username = root
Password = P@$$w0rd

-- Create a static ip address for your superset vm.
gcloud compute addresses create superset \
 --project=glassy-storm-412817 \
 --description="Reserved Apache Superset Static IP Address" \
 --network-tier=STANDARD \
 --region=us-east1

STATIC_IP=$(gcloud compute addresses describe superset \
 --project=glassy-storm-412817 \
 --region=us-east1 \
 --format='value(address)')

# To see the static ip address echo $STATIC_IP

echo http://$STATIC_IP

gcloud compute instances delete-access-config superset \
 --project=glassy-storm-412817 \
 --zone=us-east1-c \
 --access-config-name="External NAT" \
 --quiet

gcloud compute instances add-access-config superset \
 --project=glassy-storm-412817 \
 --zone=us-east1-c \
 --address=$STATIC_IP \
 --network-tier=STANDARD

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

What is the average price of the house in New York ?
SELECT AVG(price) FROM `NYHouse`;

What is the average square feet of the house in New York ?
SELECT AVG(PropertySqft) FROM `NYHouse`;

Who are the ten top performing brokers ?
SELECT BrokerTitle,COUNT(_) FROM NYHouse GROUP BY BrokerTitle ORDER BY COUNT(_) DESC LIMIT 10;

Which SubLocality has the highest price ?
SELECT SubLocality, AVG(Price) AS AveragePrice, COUNT(SubLocality) AS NumberOfProperties, AVG(PropertySqft) AS AveragePropertySqft FROM NYHouse GROUP BY SubLocality ORDER BY AVG(Price) DESC;

Compare the price and property sq ft in different sublocalities.
SELECT SubLocality, AVG(Price) AS AveragePrice, COUNT(SubLocality) AS NumberOfProperties, AVG(PropertySqft) AS AveragePropertySqft FROM NYHouse GROUP BY SubLocality ORDER BY AveragePropertySqft DESC;

Which property type has the highest price in New York? aka List of the average price of the house based on their property type
SELECT Type, AVG(Price) AS AveragePrice, COUNT(SubLocality) AS NumberOfProperties, AVG(PropertySqft) AS AveragePropertySqft FROM NYHouse GROUP BY Type Order By AveragePrice DESC;

Which property type has the highest price filtered on major 7 types?
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
COUNT(\*) AS NumberOfProperties,
AVG(PropertySqft) AS AveragePropertySqft
FROM
NYHouse
GROUP BY
PropertyType
ORDER BY
AveragePrice;

Database Backup

Create a directory to store the backup
sudo mkdir -p /usr/local/bin/NYHouse
sudo chown -R bryan:staff /usr/local/bin/NYHouse

util.dumpSchemas(["final-aung"], "NYHouse", {"compression": "none", "threads": 6, chunking: false})

SQL Procedures

DELIMITER |
CREATE PROCEDURE getHousingListAndAveragePrice()
BEGIN
SELECT \* FROM NYHouse;
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

Testing with Top 5 Boroughs
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

Testing with demanding property type
CALL getAveragePriceOfPropertyType('%condo%'); -- generate average price of condo and condop
CALL getAveragePriceOfPropertyType('%family%');
CALL getAveragePriceOfPropertyType('%house%'); -- generate average price of house, mobile house and town house
CALL getAveragePriceOfPropertyType('%land%');

SHOW PROCEDURE STATUS WHERE Db='final-aung'; -- show the procedures created

CREATE VIEW NYHousingView AS
SELECT 'mysql' dbms,t.TABLE_SCHEMA,t.TABLE_NAME,c.COLUMN_NAME,c.ORDINAL_POSITION,c.DATA_TYPE,c.CHARACTER_MAXIMUM_LENGTH,n.CONSTRAINT_TYPE,k.REFERENCED_TABLE_SCHEMA,k.REFERENCED_TABLE_NAME,k.REFERENCED_COLUMN_NAME FROM INFORMATION_SCHEMA.TABLES t LEFT JOIN INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_SCHEMA=c.TABLE_SCHEMA AND t.TABLE_NAME=c.TABLE_NAME LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE k ON c.TABLE_SCHEMA=k.TABLE_SCHEMA AND c.TABLE_NAME=k.TABLE_NAME AND c.COLUMN_NAME=k.COLUMN_NAME LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS n ON k.CONSTRAINT_SCHEMA=n.CONSTRAINT_SCHEMA AND k.CONSTRAINT_NAME=n.CONSTRAINT_NAME AND k.TABLE_SCHEMA=n.TABLE_SCHEMA AND k.TABLE_NAME=n.TABLE_NAME WHERE t.TABLE_TYPE='BASE TABLE' AND t.TABLE_SCHEMA NOT IN('INFORMATION_SCHEMA','mysql','performance_schema');
