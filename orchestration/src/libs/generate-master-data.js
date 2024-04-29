const globalPBIDatasetCfg = require('../config/global/pbi_dataset.json');
const fs = require('fs');

var _ = require('lodash');

function pbiDatasetGenerateJSON (env) {
    
    const envPBIDatasetCfg = require('../config/' + env + '/pbi_dataset.json');
    let pbiDatasetCfg = _.merge(globalPBIDatasetCfg, envPBIDatasetCfg);
    let pbiDatasetArray = [];

    Object.keys(pbiDatasetCfg).forEach(function(workspaceKey){
        let workspace = pbiDatasetCfg[workspaceKey];
        Object.keys(workspace.datasets).forEach(function(datasetKey){
            let dataset = workspace.datasets[datasetKey];
            pbiDatasetArray.push({
                "pbi_dataset_id": dataset.pbi_dataset_id,
                "workspace_guid": workspace.workspace_guid,
                "workspace_name": workspaceKey,
                "dataset_guid": dataset.dataset_guid,
                "dataset_name": datasetKey,
                "schedule_recurrence": dataset.schedule_recurrence,
                "schedule_day": dataset.schedule_day
            });
        });       
    });

    return JSON.stringify(pbiDatasetArray, null, '\t');
}

function pbiDatasetGenerateCSV (env) {

    const envPBIDatasetCfg = require('../config/' + env + '/pbi_dataset.json');
    let pbiDatasetCfg = _.merge(globalPBIDatasetCfg, envPBIDatasetCfg);
    let pbiDatasetArray = [[
        "pbi_dataset_id",
        "workspace_guid",
        "workspace_name",
        "dataset_guid",
        "dataset_name",
        "schedule_recurrence",
        "schedule_day"
    ]];
    let csvContent = "";
    
    Object.keys(pbiDatasetCfg).forEach(function(workspaceKey){
        let workspace = pbiDatasetCfg[workspaceKey];
        Object.keys(workspace.datasets).forEach(function(datasetKey){
            let dataset = workspace.datasets[datasetKey];
            pbiDatasetArray.push([
                dataset.pbi_dataset_id,
                workspace.workspace_guid,
                workspaceKey + (env != 'prod' ? '_' + env.toUpperCase() : ''),
                dataset.dataset_guid,
                datasetKey,
                dataset.schedule_recurrence,
                dataset.schedule_day
            ]);
        });       
    });

    return csvContent + pbiDatasetArray.map(e => e.join(",")).join("\r\n") + "\r\n";
}

function pbiDatasetEntityGenerateCSV (env) {
    const envPBIDatasetCfg = require('../config/' + env + '/pbi_dataset.json');
    let pbiDatasetCfg = _.merge(globalPBIDatasetCfg, envPBIDatasetCfg);
    let pbiDatasetEntityArray = [[
        "pbi_dataset_id",
        "dataset_name",
        "entity_id",
        "schema_name",
        "entity_name"
    ]];
    let csvContent = "";
    let entities = require('../config/global/entity.json');//.edw.entities;
    
    Object.keys(pbiDatasetCfg).forEach(function(workspaceKey){
        let workspace = pbiDatasetCfg[workspaceKey];
        Object.keys(workspace.datasets).forEach(function(datasetKey){
            let dataset = workspace.datasets[datasetKey];
            Object.keys(dataset.entities).forEach(function(sourceKey){
                let datasetEntities = dataset.entities[sourceKey];
                datasetEntities.forEach(function(entityName){
                    let entitySource = entities[sourceKey];
                    let schemaName = entitySource.schema_name;
                    let entity_id = entitySource.entities.find(e => e.entity_name === entityName).entity_id;
                    pbiDatasetEntityArray.push([
                        dataset.pbi_dataset_id,
                        datasetKey,
                        entity_id,
                        schemaName,
                        entityName
                    ]);
                });
            });                
        });       
    });

    return csvContent + pbiDatasetEntityArray.map(e => e.join(",")).join("\r\n") + "\r\n";
}

function entityGenerateCSV (env) {

    const globalEntityCfg = require('../config/global/entity.json');
    const envEntityCfg = require('../config/' + env + '/entity.json');
    let entityCfg = _.merge(globalEntityCfg, envEntityCfg);
    let entityHeader = [
        "entity_id",
        "entity_name",
        "level_id",
        "layer_id",
        "adls_container_name",
        "data_category",
        "client_field",
        "tool_name",
        "extraction_type",
        "update_mode",
        "base_schema_name",
        "base_table_name",
        "base_sproc_name",
        "axbi_database_name",
        "axbi_schema_name",
        "axbi_date_field_name",
        "sproc_schema_name",
        "sproc_name",
        "source_schema_name",
        "source_view_name",
        "dest_schema_name",
        "dest_table_name",
        "execution_order",
        "pk_field_names",
        "schedule_recurrence",
        "schedule_start_date",
        "schedule_day"
    ];
    let entityArray = [entityHeader];
    let csvContent = "";

    Object.keys(entityCfg).forEach(function(sourceKey){
        let source = entityCfg[sourceKey];
        source.entities.forEach(function(entity){

            // add the properties set on source level to the entities
            Object.keys(source).forEach(function(sourceProp){
                if(sourceProp !== "entities"){
                    entity[sourceProp] = source[sourceProp];
                }
            });

            entityArray.push(
                [entityHeader.map(
                    h => typeof entity[h] === "string" ? '"' + entity[h] + '"' : entity[h]
                )
            ]);
        });       
    });

    return csvContent + entityArray.map(e => e.join(",")).join("\r\n") + "\r\n";
}

function writePBIDatasetCSV (env) {
    fs.writeFileSync(
        './Master Data/' + env + '/pbi_dataset.csv', 
        pbiDatasetGenerateCSV(env)
    );
}

function writePBIDatasetEntityCSV (env) {
    fs.writeFileSync(
        './Master Data/' + env + '/pbi_dataset_entity.csv', 
        pbiDatasetEntityGenerateCSV(env)
    );
}

function writeEntityCSV (env) {
    fs.writeFileSync(
        './Master Data/' + env + '/entity.csv', 
        entityGenerateCSV(env)
    );
}

module.exports = {
    writeMasterDataCSV: function () {
        ['dev', 'test', 'qas', 'prod'].forEach(function(env){
            writePBIDatasetCSV(env);
            writePBIDatasetEntityCSV(env);
            writeEntityCSV(env);
        });
    }
};
