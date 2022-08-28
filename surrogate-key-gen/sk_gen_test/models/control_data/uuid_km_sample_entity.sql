{{
    config(materialized="incremental")
}}

select
    sk_id as id
    , src_key
from {{ ref('uuid_newkm_sample_entity') }}