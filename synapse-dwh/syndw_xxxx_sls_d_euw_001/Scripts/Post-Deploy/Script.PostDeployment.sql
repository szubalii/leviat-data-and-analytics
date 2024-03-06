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

EXEC [utilities].[sp_ingest_master_data];

-- ;
-- GO

ALTER TABLE
  [base_s4h_cax].[I_BrandText]
ADD
  [t_applicationId] VARCHAR   (32)
, [t_jobId]         VARCHAR   (36)
, [t_jobDtm]        DATETIME
, [t_jobBy]  		   NVARCHAR  (128)
, [t_extractionDtm]	DATETIME
, [t_filePath]     NVARCHAR (1024);
GO
 