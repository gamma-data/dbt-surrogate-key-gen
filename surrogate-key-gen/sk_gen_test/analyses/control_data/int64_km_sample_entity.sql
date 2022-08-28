-- key map table for the entity with int64 surrogate keys

create table {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.int64_km_sample_entity (
    id int64
    , src_key STRING
)
cluster by src_key;
