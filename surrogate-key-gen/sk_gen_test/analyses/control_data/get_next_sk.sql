-- stored proc to increment the surrogate key high water mark
-- effectively allocating a block of new key values
-- returns the starting key value of the new block

CREATE OR REPLACE PROCEDURE {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.get_next_sk(
    IN src_name STRING,
    IN rec_cnt INT64,
    OUT next_sk INT64
)
BEGIN
  DECLARE new_next_sk INT64;

  -- if the record count is 0, just return the "next_sk" - skip the no-op update

  IF rec_cnt > 0 THEN
    -- perform update and retrieval in the one transaction
    BEGIN TRANSACTION;
      UPDATE {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.key_map km
        SET km.next_sk = km.next_sk + rec_cnt
        WHERE km.source = src_name;

      SET new_next_sk = (
        SELECT km.next_sk AS new_next_sk
          FROM {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.key_map km
          WHERE km.source = src_name
      );
    COMMIT TRANSACTION;
  ELSE
    -- skip the txn and just return the value
    SET new_next_sk = (
      SELECT km.next_sk AS new_next_sk
        FROM {{ env_var('DBT_SOURCE_SCHEMA', 'dev') }}_control_data.key_map km
        WHERE km.source = src_name
    );
  END IF;
  SET next_sk = new_next_sk - rec_cnt; 
END;