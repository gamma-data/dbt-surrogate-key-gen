{{ config(materialized="view") }}

with raw_data as (
  select
    cast(src.id as STRING) as src_key
  from {{ ref('ws_sample_data') }} as src
  left outer join {{ source('control_data', 'md5_km_sample_entity') }} as km
    on cast(src.id as string) = km.src_key
  where km.id is NULL
)

select
  md5(src_key) as sk_id
  , src_key
from raw_data