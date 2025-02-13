# Module 3 Homework: Big Query Data Warehouse
This is the homework for the module 3: Questions & Answers.

## Question 1:
Question 1: What is count of records for the 2024 Yellow Taxi Data?

### Solution
- `20,332,093`

```
SELECT count(1) cnt
FROM `ny_taxi_2024.external_yellow_taxis_jan_jun_2024`;
```

## Question 2:
Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.</br> 
What is the **estimated amount** of data that will be read when this query is executed on the External Table and the Table?

### Solution
- `0 MB for the External Table and 155.12 MB for the Materialized Table`

```
SELECT COUNT(DISTINCT PULocationID) cnt_pu_loc
FROM `ny_taxi_2024.yellow_taxis_jan_jun_2024`;
```

## Question 3:
Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table. Why are the estimated number of Bytes different?

### Solution
- `BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires 
reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.`


## Question 4:
How many records have a fare_amount of 0?

### Solution
- `8,333`

```
SELECT COUNT(1) cnt
FROM `ny_taxi_2024.yellow_taxis_jan_jun_2024`
WHERE fare_amount = 0;
```

## Question 5:
What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy)

### Solution
- `Partition by tpep_dropoff_datetime and Cluster on VendorID`

```
CREATE OR REPLACE TABLE ny-rides-seb-2025.ny_taxi_2025.yellow_taxis_jan_jun_2024_partition_cluster
  PARTITION BY DATE(tpep_dropoff_datetime)
  CLUSTER BY VendorID AS
SELECT * FROM `ny_taxi_2024.yellow_taxis_jan_jun_2024`;
```

## Question 6:
Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime
2024-03-01 and 2024-03-15 (inclusive)</br>

Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values? </br>

Choose the answer which most closely matches.</br> 

### Solution
- `310.24 MB for non-partitioned table and 26.84 MB for the partitioned table`

```
SELECT DISTINCT VendorID
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024`
WHERE tpep_dropoff_datetime >= '2024-03-01'
  AND tpep_dropoff_datetime <= '2024-03-15';
--310 MB materialized table
```
```
SELECT DISTINCT VendorID
FROM `ny_taxi_2025.yellow_taxis_jan_jun_2024_partition_cluster`
WHERE tpep_dropoff_datetime >= '2024-03-01'
  AND tpep_dropoff_datetime <= '2024-03-15';
--26.84 MB partitioned and clustered table
```

## Question 7: 
Where is the data stored in the External Table you created?

### Solution
- `GCP Bucket`

## Question 8:
It is best practice in Big Query to always cluster your data:

### Solution
- `False`

No, it's better to not cluster the table if it has frequent updates, complex filter conditions on clustered columns or small table size.

## (Bonus: Not worth points) Question 9:
No Points: Write a `SELECT count(*)` query FROM the materialized table you created. How many bytes does it estimate will be read? Why?#

### Solution
- `0 B`

This is because of GCP already has this information in the details of the table > number of rows (metadata).