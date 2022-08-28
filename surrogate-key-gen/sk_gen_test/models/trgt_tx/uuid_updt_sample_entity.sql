-- identify the new records that don't yet have a natural key

select
  km.id as sk_id
  , cast(src.id as STRING) as src_key
  , src.*
from {{ ref('ws_sample_data') }} as src
join {{ source('control_data', 'uuid_km_sample_entity') }} as km
  on cast(src.id as string) = km.src_key