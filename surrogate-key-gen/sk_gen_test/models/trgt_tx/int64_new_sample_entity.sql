-- identify the new records that don't yet have a natural key

select
  src.id as src_key
  -- , km.id as sk_id
  -- , src.*
from {{ ref('ws_sample_data') }} as src
left outer join {{ source('control_data', 'int64_km_sample_entity') }} as km
  on cast(src.id as string) = km.src_key
where km.id is NULL