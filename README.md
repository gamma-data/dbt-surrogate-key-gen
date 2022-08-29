# dbt spikes and pocs

## surrogate key gen
Example patterns for surrogate key generation and entity key mapping.

Several days of `sample_data` source data is mapped into a `sample_entity`.

### Surrogate key generation patterns
* Allocated Numeric Key - a unique numeric key is allocated to each new entity.  This example uses a
key block allocation approach as opposed to a `max_key + 1` approach to avoid executing a `max` aggregate
method on the key map table.
* UUID Key - allocate a random UUID value for each new entity
* md5 Hash Key - calculate an md5 hash value from the source data natural key values.  Because the md5
hash approach is deterministic, a key map table isn't really required, but can be useful for downstream
data transformation, e.g. referential integrity and augmentation.

Each pattern follows similar processing steps:
| Step | Action |
| ---- | ------ |
| `ws_sample_data` | select a working set of `source_data`.  In this case, the source data has a partition date identifier. |
| `updt_sample_entity` | update records | identify the sample data records that already have surrogate keys allocated via inner join with the key map table. |
| `new_sample_entity` | identify the sample data records that do not yet have surrogate keys allocated via an outer join with the key map table. |
| `newkm_sample_entity` | allocate surrogate keys to the new records, persisted as a table as opposed to view so that the numeric or uuid based id's allocated are stable. |
| `km_sample_entity` | updating the sample entity key map table with the new surrogate key values.  Materialised as an `incremental` table. Could also be applied using snapshots. |
| `tx_sample_entity` | the union of new and updated entities for this batch, ready for application to the target table. |

As the `km_sample_entity` is used as both an input into the models as well as an output, the `km_sample_entity` table is
included as both a `source` and a `model`.