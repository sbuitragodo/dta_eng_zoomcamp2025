{{ config(materialized='table') }}

with tripdata as (
    select *
    from {{ ref('fact_trips') }}
),
trips_data_metrics as (
    select
      service_type,
      extract(year from pickup_datetime) as year_pickup,
      extract(month from pickup_datetime) as month_pickup,
      fare_amount
    from tripdata
    where fare_amount > 0
    and trip_distance > 0
    and payment_type_description in ('Cash', 'Credit Card')
)
select
  service_type,
  percentile_cont(fare_amount, 0.97) over (partition by service_type) as p97,
  percentile_cont(fare_amount, 0.95) over (partition by service_type) as p95,
  percentile_cont(fare_amount, 0.90) over (partition by service_type) as p90
from trips_data_metrics
where year_pickup = 2020
and month_pickup = 4