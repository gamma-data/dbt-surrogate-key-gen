{{
    config(
      materialized="table"
    )
}}

with raw_data as (
    select
        *
    from {{ ref('uuid_new_sample_entity') }}
)

select
  generate_uuid() as sk_id
  , raw_data.*
from raw_data