

with new_recs as (
    select *
    from {{ ref('newkm_sample_data') }}
), updt_recs as (
    select *
    from {{ ref('updt_sample_data') }}
)
select * from updt_recs
union all (select * from new_recs)