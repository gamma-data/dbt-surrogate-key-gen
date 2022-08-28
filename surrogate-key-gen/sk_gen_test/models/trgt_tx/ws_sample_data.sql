
{{ config(materialized='table') }}
{%- set partition_dt = var('partition_dt') -%}

select
    partition_dt
    , cast(ID as STRING) as id
    , Job_Title as job_title
    , Email_Address as email_address
    , FirstName_LastName as firstname_lastname

    , "{{ invocation_id }}" as job_rfrnc
    , "{{ run_started_at }}" as job_dttm
from {{ source('raw_data', 'sample_data') }}
where partition_dt = '{{ partition_dt }}'