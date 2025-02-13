-- External table
CREATE OR REPLACE EXTERNAL TABLE ny-rides-seb-2025.ny_taxi_2025.external_yellow_taxis_jan_jun_2024
  OPTIONS(
    format ="PARQUET",
    uris = ['gs://dezoomcamp_hw3_2025_ny-rides-seb-2025/yellow_tripdata_2024-*.parquet']
    );

-- Materialized table
CREATE OR REPLACE TABLE ny-rides-seb-2025.ny_taxi_2025.yellow_taxis_jan_jun_2024 AS
SELECT * FROM `ny_taxi_2025.external_yellow_taxis_jan_jun_2024`;

-- Question 1
SELECT COUNT(1) cnt
FROM `ny_taxi_2025.external_yellow_taxis_jan_jun_2024`
;

-- Question 2
SELECT COUNT(DISTINCT PULocationID) cnt_pu_loc
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024`
;

-- Question 3
SELECT PULocationID, DOLocationID
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024`;

-- Question 4
SELECT COUNT(1) cnt
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024`
WHERE fare_amount = 0;

-- Question 5
CREATE OR REPLACE TABLE ny-rides-seb-2025.ny_taxi_2025.yellow_taxis_jan_jun_2024_partition
  PARTITION BY DATE(tpep_dropoff_datetime) AS
SELECT * FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024`;

CREATE OR REPLACE TABLE ny-rides-seb-2025.ny_taxi_2025.yellow_taxis_jan_jun_2024_partition_cluster
  PARTITION BY DATE(tpep_dropoff_datetime)
  CLUSTER BY VendorID AS
SELECT * FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024`;

SELECT DATE_TRUNC(tpep_dropoff_datetime, MONTH) tpep_month, VendorID, count(1) cnt 
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024_partition`
WHERE tpep_dropoff_datetime BETWEEN '2024-02-01' AND '2024-04-01'
GROUP BY 1, 2
ORDER BY VendorID;

SELECT DATE_TRUNC(tpep_dropoff_datetime, MONTH) tpep_month, VendorID, count(1) cnt 
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024_partition_cluster`
WHERE tpep_dropoff_datetime BETWEEN '2024-02-01' AND '2024-04-01'
GROUP BY 1, 2
ORDER BY VendorID;

-- Question 6
SELECT DISTINCT VendorID
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024`
WHERE tpep_dropoff_datetime >= '2024-03-01'
  AND tpep_dropoff_datetime <= '2024-03-15';
--310 MB materialized table

SELECT DISTINCT VendorID
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024_partition_cluster`
WHERE tpep_dropoff_datetime >= '2024-03-01'
  AND tpep_dropoff_datetime <= '2024-03-15';
--26.84 MB partitioned and clustered table

--Question 9
SELECT count(*) cnt
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024`;
