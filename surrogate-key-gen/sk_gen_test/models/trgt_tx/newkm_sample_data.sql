{{
    config(
      materialized="table"
    )
}}
{% set rec_cnt_query %}
  select count(*) from {{ ref('new_sample_data') }}
{% endset %}

{%- set next_sk = 0 %}

{% if execute %}
    {%- set new_rec_cnt_result = run_query(rec_cnt_query) %}
    {% set new_rec_cnt = new_rec_cnt_result.columns[0].values()[0] %}
    {{ log(this.schema ~ "." ~ this.identifier ~ ": new records: " ~ new_rec_cnt, info=True) }}
    {% set next_sk_query %}
        declare next_sk INT64;
        call dev_control_data.get_next_sk('sample_data', {{ new_rec_cnt }}, next_sk);
        select next_sk;
    {% endset %}
    {% set next_sk_result = run_query(next_sk_query) %}
    {% set next_sk = next_sk_result.columns[0].values()[0] %}
    {{ log(this.schema ~ "." ~ this.identifier ~ ": next sk block: " ~ next_sk, info=True) }}
{% endif %}


with raw_data as (
    select
        *
    from {{ ref('new_sample_data') }}
)

select
  row_number() over() + {{ next_sk }} - 1 as sk_id 
  , raw_data.*
from raw_data