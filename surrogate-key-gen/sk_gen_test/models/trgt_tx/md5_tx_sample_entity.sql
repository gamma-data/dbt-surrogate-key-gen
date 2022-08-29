

with new_recs as (
    select *
    from {{ ref('md5_newkm_sample_entity') }}
), updt_recs as (
    select *
    from {{ ref('md5_updt_sample_entity') }}
)
select * from updt_recs
union all (select * from new_recs)