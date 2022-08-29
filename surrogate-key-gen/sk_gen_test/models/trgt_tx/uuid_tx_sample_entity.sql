-- any new records will have been added to the keymap table by this point
-- simple inner join should yield the desired record set with keys assigned

{{ config(materialized="view") }}

with src_recs as (
    select
      km.id as sk_id
      , cast(src.id as STRING) as src_key
      , src.*
    from {{ ref('ws_sample_data') }} as src
    join {{ ref('uuid_km_sample_entity') }} as km
      on cast(src.id as string) = km.src_key
)
select * from src_recs