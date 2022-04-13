CREATE TABLE [log].pipeline (
    Existing_pipeline_id			BIGINT
,   Existing_pipeline_name_nk		VARCHAR (140)
,	Existing_pipeline_description	VARCHAR (250)
,   Existing_parent_pipeline_id	    BIGINT
,   Existing_pipeline_order		    INT	
,	ActionTaken                     nvarchar(10)
,   New_pipeline_id			        BIGINT
,   New_pipeline_name_nk		    VARCHAR (140)
,	New_pipeline_description	    VARCHAR (250)
,   New_parent_pipeline_id	        BIGINT
,   New_pipeline_order		        INT	
,   t_jobDtm                        DATETIME
); 