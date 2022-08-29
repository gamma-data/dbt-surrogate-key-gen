{{
    config(
        materialized="incremental"
        , unique_key = ['id']
    )
}}

select
    sk_id as id
    , src_key
from {{ ref('md5_newkm_sample_entity') }}