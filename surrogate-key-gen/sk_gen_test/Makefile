
DBT_SOURCE_SCHEMA := $(or $(DBT_SOURCE_SCHEMA), dev)


.PHONY: dbt-run


dbt-run-sk-gen:
	dbt run --vars \
	    "{'partition_dt': $(PARTITION_DT)}" \
		--exclude tag:src_data
