# surrogate key generation
Approaches for surrogate key generation that don't rely on hash functions.

## incrementing key value from block
Assumptions:
There is a service/function that can provide a starting value given a request for N new id's.
The service/function is responsible for maintaining the high water mark.  Want to avoid using "max"
functions on the target table.

The dbt model, then uses this value to generate new key values.

Given a record count, return a starting value and update the high watermark.

```plantuml
@startuml
class key_idx {
    id: key id
    next_val: the next key value to assign
}

class trgt_tbl {
    id: surrogate key value
    natural_key: natural key value
}

trgt_tbl -> key_idx

@enduml
```
