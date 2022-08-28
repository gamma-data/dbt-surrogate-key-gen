

with new_recs as (
    select *
    from {{ ref('int64_newkm_sample_entity') }}
), updt_recs as (
    select *
    from {{ ref('int64_updt_sample_entity') }}
)
select * from updt_recs
union all (select * from new_recs)