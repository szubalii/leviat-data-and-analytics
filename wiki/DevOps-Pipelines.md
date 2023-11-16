# Azure DevOps Pipelines 

The CRH Leviat DnA Project comprises of various technical implementations: 

- Azure Data Factory 
- Azure SQL Database 
- Azure Synapse Workspace with dedicated sql pool 
- Theobald Xtract Universal 

Azure DevOps pipelines are used for validation, testing, building and deployment of these various solutions. Each of these solutions are deployed to a dedicated resource but are contained in a single ‘mono’-repository. This document describes how Azure DevOps pipelines are structured, designed, and implemented. 

The setup is as follows: 

1. Solution-specific Test pipelines 
    - Triggered by PR creation and path filter 
2. Project-wide Validation pipeline 
    - Triggered by PR creation 
3. Solution-specific Build pipelines 
    - Triggered by PR completion and path filter 
4. Solution-specific Deploy Pipelines 
    - Triggered when corresponding build pipeline successfully completes 
5. Helper pipeline triggered manually to build all solutions 

## Separate build and deployment pipelines 

Having separate build and deployment pipelines allows for running the deployment of an already existing build artifact without running the build steps again. In the case of having a single pipeline that handles both build and deployment, and one only requires to re-run the deployment steps, the build steps always will be executed when triggering a new run of this pipeline. Having separate build and deployment pipelines enables a shorter pipeline duration for these scenarios.   

## Solution-specific pipelines 

Having separate solutions pipelines, i.e., one pipeline handles the build of Azure Data Factory, while another pipeline handles the build of Azure Synapse SQL Pool, allows for shorter pipeline duration times.  

Whenever a new pull request with solution specific changes, say for Azure Data Factory only, is completed into main branch, no new build of the other solutions is required. 

## Solution-specific Test pipelines 

Each solution has its own test pipeline that runs through various test cases and checks if they can be successfully completed. Each test pipeline tests the sound working of its solution only i.e., the test pipeline for Synapse SQL pool only tests the logic of its artifacts, and not its relation and dependency to the Orchestration DB or Azure Data Factory.  

This pipeline is triggered when a new PR into a release branch is created.  

## Project-wide validation pipeline 

The validation pipeline focusses specifically on the integration of the various solutions. It tests the dependencies between the solutions and checks if they work together correctly. When changing a single solution, this can impact the behavior of another solution.  

This validation is triggered whenever a PR into main branch is created and is required to succeed before the PR can be completed.  

The following dependencies have been identified: 

1. Table, view and stored procedure references in the Orchestration DB should exist in the Synapse SQL Pool 
2. Extraction name references in the Orchestration DB should exist in the Xtract Universal configuration 
3. Table, view and stored procedure references of SQL scripts in Azure Data Factory should exist in Synapse SQL Pool 
4. Table, view and stored procedure references of SQL scripts in Azure Data Factory should exist in Orchestration DB 
5. Extracted fields in Xtract Universal extraction configurations should exist in Synapse SQL Pool 
6. Field data types of Xtract Universal extractions should correspond to field data types in Synapse SQL Pool 
7. Workspace and dataset guid references in Orchestration DB should exist in Power BI 

## Scenarios 

A number of scenarios can be identified: 
1. Manual build of feature branch 
2. Manual deployment to personal environment 
3. Triggered deployment to personal environment 
4. Triggered build of release branch 
5. Triggered deployment to release environment  
  a. When a new build of release branch is successfully completed, the new build will be deployed to the corresponding release environment 
6. Manual build of release branch 
7. Manual deployment to release environment 
8. Manual Build of Feature Branch 

### When a developer requires testing if a solution in feature branch results in successful build 

Use the solution specific build pipeline to build a particular solution. 

### Manual deployment to personal environment 

When a developer requires testing of a solution in feature branch in personal environment 
Select a previously created solution build when manually triggering the pipeline.  

### Triggered deployment to personal environment 

When a solution specific build pipeline is successfully completed, the deployment pipeline is automatically triggered.   

### Triggered build of release branch 

Whenever a PR into main, qas, or prod branch is completed, this pipeline is triggered and builds the changed solution based on path filters.  

### Triggered deployment to release environment 

This deployment pipeline is triggered when the release build pipeline is successfully completed. 

## Manual build of release branch 

Manually build a release branch (main, qas, prod). 

### Manual deployment to release environment 

Manually deploying a previously created build to TEST, QAS, or PROD. 
Select a previously created build. 

## Definitions 

#### Feature branch 

A new branch started as a copy of main branch whenever implementation of a new user story is started.  

#### Personal environment 

Development branches of which each team member has one. 

#### Release branch 

The main, qas, and prod branches 

#### Release environment 

The environments TEST, QAS, and PROD 
 