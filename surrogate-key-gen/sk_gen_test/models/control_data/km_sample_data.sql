{{
    config(materialized="incremental")
}}

select
    sk_id as id
    , src_key
from {{ ref('newkm_sample_data') }}
