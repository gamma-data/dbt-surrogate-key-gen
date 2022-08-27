
{{ config(materialized='table') }}
{%- set partition_dt = var('partition_dt') -%}

select
    partition_dt
    , ID as id
    , Job_Title as job_title
    , Email_Address as email_address
    , FirstName_LastName as firstname_lastname
    -- inject source id metadata
from {{ source('raw_data', 'sample_data') }}
where partition_dt = '{{ partition_dt }}'