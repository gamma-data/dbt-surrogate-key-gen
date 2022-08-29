{{
    config(
      materialized="table"
    )
}}

with raw_data as (
  select
    cast(src.id as STRING) as src_key
    -- , km.id as sk_id
    , src.*
  from {{ ref('ws_sample_data') }} as src
  left outer join {{ source('control_data', 'md5_km_sample_entity') }} as km
    on cast(src.id as string) = km.src_key
  where km.id is NULL
)

select
  md5(src_key) as sk_id
  , raw_data.*
from raw_data