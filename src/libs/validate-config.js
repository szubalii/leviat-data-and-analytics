const globalEntityCfg = require('../../orchestration/src/config/global/entity.json');
const fs = require('fs');
const root = process.argv[2];

var _ = require('lodash');

/**
 * main function called for this js-file.
 * starts validation for each environment.
 * Throws error in case validation errors exist.
 */
function main () {
    let exceptions = [];
    ['dev', 'qas', 'prod'].forEach(e => exceptions = exceptions.concat(validateEnvConfig(e)));

    if (exceptions.length > 0) {
        throw 'Validation Error(s)';
    }
}

function Exception (message, object) {
    this.message = message + ': ';
    this.object = object;

    console.error('##[error] ' + message, JSON.stringify(object));
}

/**
 * Executes each validation check and returns any validation errors.
 * @param {String} env dev, qas, or prod
 * @returns {Array}
 */
function validateEnvConfig (env) {
    console.log('Starting to validate orchestration configuration for ' + env + '.');

    const envEntityCfg = require('../../orchestration/src/config/' + env + '/entity.json');
    let entityCfg = _.merge(globalEntityCfg, envEntityCfg);
    let baseS4HEntityArray = entityCfg.s4h.entities;
    let exceptions = [];

    exceptions = exceptions.concat(
        checkS4HExtractionExists(baseS4HEntityArray),
        checkNoDuplicateEntityId(entityCfg),
        checkTargetTableExists(entityCfg)
    );

    console.log('Validation for ' + env + ' finished: ' + exceptions.length + ' error(s) found.');

    return exceptions;
}

/**
 * Checks if for each s4h entity a corresponding XU extraction folder exist
 * @param {Array} baseS4HEntityArray 
 * @returns array of exceptions
 */
function checkS4HExtractionExists (baseS4HEntityArray) {
    const message = 'Checking if each S4H entity has a defined XU Extraction config';
    console.log(message);
    const dir = root + '/xu-config/extractions';
    const files = fs.readdirSync(dir);
    let missingExtractions = baseS4HEntityArray.filter(e => !files.includes(e.entity_name))
        .map(e => ({entity_id: e.entity_id, entity_name: e.entity_name}));
    let exceptions = [];

    // throw Exception
    if (missingExtractions.length > 0) {
        exceptions.push(new Exception('Missing S4H Extraction(s)', missingExtractions));
    }

    console.log(message + ': Complete');

    return exceptions;
}

/**
 * Checks if no duplicate entity-ids exist
 * @param {Object} entityCfg 
 * @returns array of exceptions
 */
function checkNoDuplicateEntityId (entityCfg) {
    const message = 'Checking if no duplicate entity ids exist';
    console.log(message);
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

    console.log(message + ': Complete');

    return exceptions;
}

/**
 * Checks if for each entity the target table has a defined sql-file.
 * @param {Object} entityCfg 
 * @returns array of exceptions
 */
function checkTargetTableExists (entityCfg) {
    const message = 'Checking if each target table has a defined SQL Table DDL';
    console.log(message);
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

            let propName = (schema === 'edw') ? 'dest_table_name' : 'base_table_name';

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

    console.log(message + ': Complete');

    return exceptions;
}

module.exports = main();