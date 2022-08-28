-- key map table for the entity with uuid surrogate keys

create table {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.uuid_km_sample_entity (
    id STRING
    , src_key STRING
)
cluster by src_key;
