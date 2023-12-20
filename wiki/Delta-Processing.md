# High Level Process

1. Get delta entity batch activities

   Calculate for each delta entity, which delta parquet files need to be processed. Processing can include any of the activities from [Entity Batch Activities](#entity-batch-activities). Based on logging data in the Orchestration DB, a stored procedure calculates which activities for each delta parquet file for each delta entity is required. 
1. Process each delta entity

   1. Get the delta entity file name batch activities
   1. Process each delta entity file name batch activity

      1. Extract
      1. Get Extraction Status
      1. Store Extraction Logs
      1. Test for Duplicates
      1. Ingest into Synapse SQL Pool Base Delta
         
         (without truncate because multiple parquet files can be ingested into same base delta table)

1. If required
   1. Process the delta info in the base layer of Synapse SQL Pool   
   1. Processing of delta is successful, truncate the base delta table
      
      Full tables are only truncated when data is actually loaded from parquet to Synapse Base. For delta entities, multiple delta parquet files can be loaded into the same base table. Therefore, one cannot truncate this table before each delta file is inserted. Only truncate the base delta table in case ingestion into this table is required. 


## Entity Batch Activities

1. Extract 

   Run the Xtract Universal extraction for this delta entity and store the delta parquet file on ADLS. Additional delta fields are added to the delta entity ODP extraction:
   - TS_SEQUENCE_NUMBER

     A sequence number defining the chronological order of the delta records
   - ODQ_CHANGEMODE

     A character defining the delta operation: insert, update, delete
   - ODQ_ENTITYCNTR

     Value defining if a row is added or removed

1. Get Extraction Status
1. Store Extraction Log
1. Test for Duplicates
1. Ingest into Synapse Base

   Ingest the delta parquet file into the base delta table in Synapse SQL Pool.
1. Process Base

   For a delta entity, this step is executed after all required delta parquet files have been ingested into Synapse SQL Pool Base. It processes the new delta parquet files and applies the delta information in the active table that contains the latest up to date status.

# Delta structure in Synapse SQL Pool

## Base

<entity_delta>

Contains delta records from potentially multiple delta parquet files

<vw_entity_delta>
1. In a single delta parquet file, multiple updates on the same key can exist
1. Additionaly, multiple delta parquet files can be ingested into the same delta table.

This view retrieves the most recent status for each key taking into account point 1 and 2. 

<sp_entity_active>

Stored Procedure that updates existing records and inserts new records in <entity_active> based on <vw_entity_delta>. This stored procedure is executed during the **Process Base** step. 

<entity_active>

Contains the actual latest status of all previously ingested delta parquet files. This table allows us to compare the data between full load and delta load.

## EDW


# Scenarios

1. What if only Process Base activity is required? If by default, delta tables are being truncated, we need to re-ingest corresponding delta parquet files into Synapse SQL Pool. 