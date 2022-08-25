-- stored proc to increment the surrogate key high water mark
-- effectively allocating a block of new key values
-- returns the starting key value of the new block

CREATE OR REPLACE PROCEDURE dev_control_data.get_next_sk(
    IN src_name STRING,
    IN rec_cnt INT64,
    OUT next_sk INT64
)
BEGIN
  DECLARE new_next_sk INT64;

  -- perform update and retrieval in the one transaction
  BEGIN TRANSACTION;
  UPDATE dev_control_data.key_map km
  SET km.next_sk = km.next_sk + rec_cnt
  WHERE km.source = src_name;

  SET new_next_sk = (
    SELECT km.next_sk as new_next_sk
    from dev_control_data.key_map km
    where km.source = src_name
  );
  COMMIT TRANSACTION;
  SET next_sk = new_next_sk - rec_cnt; 
END;