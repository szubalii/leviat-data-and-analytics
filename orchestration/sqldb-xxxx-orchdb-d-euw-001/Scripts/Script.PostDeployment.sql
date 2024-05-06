/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

:r .\DatabaseScopedCredential.sql
:r .\Merge.batch_activity.sql
:r .\Merge.batch_execution_status.sql
:r .\Merge.error_category.sql
:r .\Merge.location.sql -- load location before layer, due to foreign key in layer
:r .\Merge.layer.sql    -- load layer before entity, due to foreign key in entity
:r .\Merge.level.sql    -- load level before entity, due to foreign key in entity
:r .\Merge.layer_activity.sql
:r .\Merge.entity.sql
:r .\Merge.pbi_dataset.sql
:r .\Merge.pbi_dataset_entity.sql
:r .\Merge.pipeline.sql
:r .\Merge.pipeline_execution_status.sql
:r .\Merge.recipient_email_address.sql