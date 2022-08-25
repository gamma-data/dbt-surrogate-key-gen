-- identify the new records that don't yet have a natural key

select
  km.id as sk_id
  , cast(src.id as STRING) as src_key
  , src.*
from {{ ref('ws_sample_data') }} as src
join {{ source('dev_control_data', 'km_sample_data') }} as km
  on cast(src.id as string) = km.src_key