{{ config(materialized='table') }}

with tripdata as (
    select *
    from {{ ref('fact_trips') }}
),
trips_data_metrics as (
    select
      service_type,
      extract(year from pickup_datetime) as year_pickup,
      extract(quarter from pickup_datetime) as quarter_pickup,
      extract(year from pickup_datetime) || '/Q' || extract(quarter from pickup_datetime) as year_quarter,
      sum(total_amount) as revenue_year_quarter_total_amount
    from tripdata
    group by 1, 2, 3, 4
),
lag_trips_data as (
    select
      service_type,
      year_quarter,
      revenue_year_quarter_total_amount,
      lag(revenue_year_quarter_total_amount) 
        over (partition by service_type order by service_type, quarter_pickup, year_pickup) as revenue_prev_year_quarter_total_amount
    from trips_data_metrics
    order by service_type, year_quarter
)
select
  service_type,
  year_quarter,
  revenue_year_quarter_total_amount,
  revenue_prev_year_quarter_total_amount,
  case when revenue_prev_year_quarter_total_amount = 0 then 0
  else (revenue_year_quarter_total_amount - revenue_prev_year_quarter_total_amount)/revenue_prev_year_quarter_total_amount
  end as revenue_quaterly_yoy
from lag_trips_data
