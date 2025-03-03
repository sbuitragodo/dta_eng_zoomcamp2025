{{ config(materialized='table')}}

with dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select
  *,
  extract(year from pickup_datetime) as pickup_year,
  extract(month from pickup_datetime) as pickup_month
from {{ ref('stg_fhv_data') }} as fhv_trips
inner join dim_zones as pickup_zone
on fhv_trips.pulocationid = pickup_zone.locationid
