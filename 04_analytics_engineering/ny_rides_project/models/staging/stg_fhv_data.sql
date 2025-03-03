select
  dispatching_base_num,
  pickup_datetime,
  dropoff_datetime,
  pulocationid,
  dolocationid,
  sr_flag,
  `Affiliated_base_number` as affiliated_base_number
from {{ source('staging', 'external_fhv_taxis_2019') }}
where dispatching_base_num is not null