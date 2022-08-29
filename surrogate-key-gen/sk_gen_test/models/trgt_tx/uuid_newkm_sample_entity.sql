{{
    config(
      materialized="view"
    )
}}

with raw_data as (
    select
      cast(src.id as STRING) as src_key
      -- , km.id as sk_id
      , src.*
    from {{ ref('ws_sample_data') }} as src
    left outer join {{ source('control_data', 'uuid_km_sample_entity') }} as km
      on cast(src.id as string) = km.src_key
    where km.id is NULL
)

select
  generate_uuid() as sk_id
  , raw_data.*
from raw_data