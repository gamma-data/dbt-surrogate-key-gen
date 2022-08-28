-- key map table for the entity with int64 surrogate keys

create table {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.key_map (
    , source STRING UNIQUE
    next_sk int64
)
cluster by source;

-- set an initial next key value for the sample entity
insert into {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.key_map
    (source, next_sk)
    VALUES ('sample_entity', 100)
;