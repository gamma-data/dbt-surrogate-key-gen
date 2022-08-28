-- identify the new records that don't yet have a natural key

select
  km.id as sk_id
  , src.id as src_key
  , src.*
from {{ ref('ws_sample_data') }} as src
join {{ source('control_data', 'int64_km_sample_entity') }} as km
  on src.id = km.src_key