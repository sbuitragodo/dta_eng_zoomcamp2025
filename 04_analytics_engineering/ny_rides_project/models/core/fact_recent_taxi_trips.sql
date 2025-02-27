select *
from {{ ref('fact_trips') }}
where pickup_datetime >= CURRENT_DATE - INTERVAL '30' DAY`