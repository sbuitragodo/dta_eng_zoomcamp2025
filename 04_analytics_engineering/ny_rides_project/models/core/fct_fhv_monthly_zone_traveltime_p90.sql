{{ config(materialized='table')}}

with fhv_trips as (
    select * from {{ ref('dim_fhv_trips') }}
),
trip_duration_group as (
    select
      *,
      timestamp_diff(dropoff_datetime, pickup_datetime, minute) as trip_duration
    from fhv_trips
)
select
  *,
  percentile_cont(trip_duration, 0.9) over (partition by 
    pickup_year, 
    pickup_month, 
    pulocationid,
    dolocationid
  ) as p90_trip_duration
from trip_duration_group