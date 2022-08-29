-- key map table for the entity with deterministic hash based surrogate keys
-- BQ supports multiple hashing functions.  md5 is choosen as it's the default used by dbt.

create table {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.md5_km_sample_entity (
    id BYTES
    , src_key STRING
)
cluster by src_key;
