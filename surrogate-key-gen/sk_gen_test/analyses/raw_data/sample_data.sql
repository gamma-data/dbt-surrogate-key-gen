/*
Helper to create the sample data table from the seed data files.
Mimics an partitioned external table from object storage.
*/

create table sample_data as (
with data_001 as (
    select
        safe_cast('2022-08-20' as DATE) as partition_dt
        , *
    from {{ ref('data-001') }}
),
data_002 as (
    select
        cast('2022-08-21' as DATE) as partition_dt
        , *
    from {{ ref('data-002') }}
),
data_003 as (
    select
        cast('2022-08-22' as DATE) as partition_dt
        , *
    from {{ ref('data-003') }}
)

select * from data_001
union all (select * from data_002)
union all (select * from data_003)
)