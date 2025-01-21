# Module 1 Homework: Docker & SQL

This is the homework for the module 1: Questions & Answers.

## Question 1. Understanding docker first run 

Run docker with the `python:3.12.8` image in an interactive mode, use the entrypoint `bash`.

What's the version of `pip` in the image?

### Solution:
The pip version in the image is:

- `24.3.1`

Command
```
docker run -it python:3.12.8 bash
```

## Question 2. Understanding Docker networking and docker-compose

Given the following `docker-compose.yaml`, what is the `hostname` and `port` that **pgadmin** should use to connect to the postgres database?

### Solution:
The hostname and port in the connection are:

- `db:5432`

Command
```
docker-compose up
```

## Question 3. Trip Segmentation Count

During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, **respectively**, happened:
1. Up to 1 mile
2. In between 1 (exclusive) and 3 miles (inclusive),
3. In between 3 (exclusive) and 7 miles (inclusive),
4. In between 7 (exclusive) and 10 miles (inclusive),
5. Over 10 miles 

### Solution
5 segments "0-1, 1-3, 3-7, 7-10, over 10" during the required period with the following values:

- `104,802;  198,924;  109,603;  27,678;  35,189`

Command
```
python ingest_data.py --user=postgres --password=postgres  --host=localhost   --port=5433   --db=ny_taxi   --table_name=green_taxi_trips
```

```
select 
  case
    when trip_distance <= 1 then '1. 0-1 miles'
    when trip_distance > 1 and trip_distance <= 3 then '2. 1-3 miles'
    when trip_distance > 3 and trip_distance <= 7 then '3. 3-7 miles'
    when trip_distance > 7 and trip_distance <= 10 then '4. 7-10 miles'
    else '5. over 10 miles'
  end trip_distance_segment,
  count(*) cnt_trips
from green_taxi_trips
where lpep_pickup_datetime::date >= '2019-10-01' and lpep_dropoff_datetime::date < '2019-11-01'
group by 1
order by 1;
```

## Question 4. Longest trip for each day

Which was the pick up day with the longest trip distance?
Use the pick up time for your calculations.

### Solution
- `2019-10-31`

Command
```
select lpep_pickup_datetime::date aslpep_pickup_date
from green_taxi_trips
where trip_distance in (
    select max(trip_distance)
    from green_taxi_trips
);
```

## Question 5. Three biggest pickup zones

Which were the top pickup locations with over 13,000 in
`total_amount` (across all trips) for 2019-10-18?

Consider only `lpep_pickup_datetime` when filtering by date.

### Solution
- `East Harlem North, East Harlem South, Morningside Heights`

Command
```
select taxi_zones."Zone", count(1) cnt_zones_over_13
from green_taxi_trips
left join taxi_zones on green_taxi_trips."PULocationID" = taxi_zones."LocationID"
where lpep_pickup_datetime::date = '2019-10-18'
and total_amount > 13
group by 1
order by cnt_zones_over_13 desc
limit 3;
```

## Question 6. Largest tip

For the passengers picked up in October 2019 in the zone
named "East Harlem North" which was the drop off zone that had
the largest tip?

Note: it's `tip` , not `trip`

We need the name of the zone, not the ID.

### Solution
- `JFK Airport`

Command
```
with pkup_east_harlem_north as (
  select "DOLocationID" do_location, max(tip_amount) mx_tip
  from green_taxi_trips
  left join taxi_zones on green_taxi_trips."PULocationID" = taxi_zones."LocationID"
  where lpep_pickup_datetime::date >= '2019-10-01' and lpep_pickup_datetime::date <= '2019-10-31'
  and "Zone" = 'East Harlem North'
  group by 1
  order by mx_tip desc
)
select "Zone", mx_tip
from pkup_east_harlem_north
left join taxi_zones on pkup_east_harlem_north.do_location = taxi_zones."LocationID"
order by mx_tip desc
limit 3;
```

## Terraform

In this section homework we'll prepare the environment by creating resources in GCP with Terraform.

In your VM on GCP/Laptop/GitHub Codespace install Terraform. 
Copy the files from the course repo
[here](../../../01-docker-terraform/1_terraform_gcp/terraform) to your VM/Laptop/GitHub Codespace.

Modify the files as necessary to create a GCP Bucket and Big Query Dataset.


## Question 7. Terraform Workflow

Which of the following sequences, **respectively**, describes the workflow for: 
1. Downloading the provider plugins and setting up backend,
2. Generating proposed changes and auto-executing the plan
3. Remove all resources managed by terraform`

### Solution
- `terraform init, terraform apply -auto-approve, terraform destroy`