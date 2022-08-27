-- identify the new records that don't yet have a natural key

select
  cast(src.id as STRING) as src_key
  -- , km.id as sk_id
  , src.*
from {{ ref('ws_sample_data') }} as src
left outer join {{ source('control_data', 'km_sample_data') }} as km
  on cast(src.id as string) = km.src_key
where km.id is NULL