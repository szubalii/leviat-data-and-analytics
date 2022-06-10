const globalEntityCfg = require('../config/global/entity.json');
const fs = require('fs');
const root = process.argv[2];

var _ = require('lodash');

function Exception (message, object) {
    this.message = message + ': ';
    this.object = object;

}

function validateEnvConfig (env) {
    console.log('Starting to validate orchestration configuration.');

    const envEntityCfg = require('../config/' + env + '/entity.json');
    let entityCfg = _.merge(globalEntityCfg, envEntityCfg);
    let baseS4HEntityArray = entityCfg.s4h.entities;
    let exceptions = [];

    exceptions = exceptions.concat(
        checkS4HExtractionExists(baseS4HEntityArray),
        checkNoDuplicateEntityId(entityCfg),
        checkTargetTableExists(entityCfg)
    );

    if (exceptions.length > 0) {
        console.error('##[error]Validation Error(s)');
        exceptions.forEach(function(e) {
            console.error('##[error]' + e.message, JSON.stringify(e.object));//, null, 2));
        });
        
        throw 'Validation Error(s)';
    }
    else {
        console.log('Validation finished. No errors found.');
    }
}

function checkS4HExtractionExists (baseS4HEntityArray) {
    console.log('Checking if each S4H entity has a defined XU Extraction config.');
    const dir = root + '/xu-config/extractions';
    const files = fs.readdirSync(dir);
    let missingExtractions = baseS4HEntityArray.filter(e => !files.includes(e.entity_name))
        .map(e => ({entity_id: e.entity_id, entity_name: e.entity_name}));
    let exceptions = [];

    // throw Exception
    if (missingExtractions.length > 0) {
        exceptions.push(new Exception('Missing S4H Extraction(s)', missingExtractions));
    }

    return exceptions;
}


function checkNoDuplicateEntityId (entityCfg) {
    console.log('Checking if no duplicate entity ids exist.');
    let entityObject = {};
    let duplicateEntityIds = [];
    let exceptions = [];

    Object.keys(entityCfg).forEach(function(k){
        let source = entityCfg[k];
        source.entities.forEach(function(e){
            if (entityObject[e.entity_id] === undefined){
                entityObject[e.entity_id] = e;
            } else {
                duplicateEntityIds.push(e.entity_id);
            }
        });
    });

    // throw Exception
    if (duplicateEntityIds.length > 0) {
        exceptions.push(new Exception('Duplicate Entity Id(s)', duplicateEntityIds));
    }

    return exceptions;
}

function checkTargetTableExists (entityCfg) {
    console.log('Checking if each target table has a defined SQL Table DDL.');
    const dir = root + '/synapse-dwh/syndw_xxxx_sls_d_euw_001'
    const schemas = Object.keys(entityCfg)
        .map(k => entityCfg[k].schema_name);
    let tables = {};
    let missingSchemas = [];
    let missingTargetTables = [];
    let exceptions = [];

    schemas.forEach(function(s) {
        let tableDir = dir + '/' + s + '/Tables';
        tables[s] = fs.readdirSync(tableDir).map(f => f.substring(0, f.length-4));
    });

    // loop over the entity config to check if for each entity
    // the referenced target base table file exists
    Object.keys(entityCfg).forEach(function(k){
        let source = entityCfg[k];
        let schema = source.schema_name;

        if (tables[schema] === undefined) {
            missingSchemas.push(schema);
        } 
        else {

            let propName = (schema === 'edw') ? 'edw_dest_table_name' : 'base_table_name';

            source.entities.forEach(function(e){
                let table_name = e[propName];
                if (table_name && !tables[schema].includes(table_name)) {
                    missingTargetTables.push(schema + '.' + table_name);
                }
            });
        }
    });

    if (missingSchemas.length > 0) {
        exceptions.push(new Exception('Missing Schema(s)', missingSchemas));
    }

    if (missingTargetTables.length > 0) {
        exceptions.push(new Exception('Missing Target Table(s)', missingTargetTables));
    }

    return exceptions;
}


// validateEnvConfig ('dev')

module.exports = validateEnvConfig('dev'); //function () {
//     const envEntityCfg = require('../config/' + env + '/entity.json');
//     // let pbiDatasetCfg = _.merge(globalPBIDatasetCfg, envPBIDatasetCfg);
//     let entityCfg = _.merge(globalEntityCfg, envEntityCfg);

    // validateEnvConfig('dev');
// }

// {
//     validateConfig: function () {
//         ['dev', 'qas', 'prod'].forEach(e => validateEnvConfig(e));
//         // validateEnvConfig(env);
//     }
// };