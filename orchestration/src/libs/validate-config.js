const globalEntityCfg = require('../config/global/entity.json');
const fs = require('fs');

var _ = require('lodash');

function Exception (message, object) {
    this.message = message + ': ';
    this.object = object;

}

function validateEnvConfig (env) {

    let exceptions = [];

    // try {

        const envEntityCfg = require('../config/' + env + '/entity.json');
        // let pbiDatasetCfg = _.merge(globalPBIDatasetCfg, envPBIDatasetCfg);
        let entityCfg = _.merge(globalEntityCfg, envEntityCfg);
        
        let baseS4HEntityArray = entityCfg.s4h.entities;

        // Object.keys(entityCfg).forEach(function(key) {
        //     if (entityCfg[key].base_schema_name) {
        //         baseEntityArray = baseEntityArray.concat(entityCfg[key].entities);
        //     }
        // });

    exceptions = exceptions.concat(
        checkS4HExtractionExists(baseS4HEntityArray),
        checkNoDuplicateEntityId(entityCfg),
        checkTargetTableExists(entityCfg)
    );

    if (exceptions.length > 0) {
        throw 'Validation Error(s): ' + JSON.stringify(exceptions, null, 2);
    }
    
    // } catch (e) {
    //     // console.error(e.message, e.object);

    //     throw e.message + ': ' + JSON.stringify(e.object, null, 2);
    // }


}

function checkS4HExtractionExists (baseS4HEntityArray) {
    const dir = '../../../xu-config/extractions';
    const files = fs.readdirSync(dir);
    let missingExtractions = baseS4HEntityArray.filter(e => !files.includes(e.entity_name));
    let exceptions = [];

    // throw Exception
    if (missingExtractions.length > 0) {
        exceptions.push(new Exception('Missing S4H Extraction(s)', missingExtractions));
    //     // throw new Exception('Missing S4H Extraction(s)', missingExtractions);
    }
    
    // console.error('Missing S4H Extraction', missingExtractions);

    return exceptions;
}


function checkNoDuplicateEntityId (entityCfg) {
    let entityObject = {};
    let duplicateEntityIds = [];
    let exceptions = [];

    Object.keys(entityCfg).forEach(function(k){
        let source = entityCfg[k];
        source.entities.forEach(function(e){
            if (entityObject[e.entity_id] === undefined){
                entityObject[e.entity_id] = e;
            } else {
                duplicateEntityIds.push(e);
            }
        });
    });

    // throw Exception
    if (duplicateEntityIds.length > 0) {
        exceptions.push(new Exception('Duplicate Entity Id(s)', duplicateEntityIds));
    //     // throw new Exception('Duplicate Entity Id(s)', duplicateEntityIds);
    }

    return exceptions;
}

function checkTargetTableExists (entityCfg) {
    const dir = '../../../synapse-dwh/syndw_xxxx_sls_d_euw_001'
    // const schemaDir = dir + '/Security/Schemas';
    const schemas = Object.keys(entityCfg)
        .map(k => entityCfg[k].schema_name);
    // fs.readdirSync(schemaDir)
    //     .map(f => f.substring(0, f.length-4));
        // .filter(dirent => dirent.isDirectory())
        // .filter(dirent => dirent.name.substring(0,5) === 'base_' );
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
    //     throw new Exception('Missing Base Schema(s): ' + missingSchemas);
    }

    if (missingTargetTables.length > 0) {
        exceptions.push(new Exception('Missing Target Table(s)', missingTargetTables));
    //     throw new Exception('Missing Target Table(s): ', missingTargetTables);
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