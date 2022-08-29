{{
    config(
      materialized="table"
    )
}}

with raw_data as (
    select
        *
    from {{ ref('md5_new_sample_entity') }}
)

select
  md5(src_key) as sk_id
  , raw_data.*
from raw_data