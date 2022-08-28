
DBT_SOURCE_SCHEMA := $(or $(DBT_SOURCE_SCHEMA), dev)

DAY_01 := 2022-08-20
DAY_02 := 2022-08-21
DAY_03 := 2022-08-22


dbt-docs-gen:
    dbt docs generate \
	    --vars "{'partition_dt': $(DAY_01)}" 

dbt-compile:
	dbt compile --vars \
	    "{'partition_dt': $(DAY_01)}"

dbt-run-day-01:
	echo hello $(DAY_00)
	dbt run --vars \
	    "{'partition_dt': $(DAY_01)}"

dbt-run-day-02:
	echo hello $(DAY_01)
	dbt run --vars \
	    "{'partition_dt': $(DAY_02)}"

dbt-run-day-03:
	dbt run --vars \
	    "{'partition_dt': $(DAY_03)}"
