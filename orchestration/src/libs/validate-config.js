const globalEntityCfg = require('../config/global/entity.json');
const fs = require('fs');

var _ = require('lodash');

function Exception (message, object) {
    this.message = 'Validation Error: ' + message;
    this.object = object;

}

function validateEnvConfig (env) {

    try {

        const envEntityCfg = require('../config/' + env + '/entity.json');
        // let pbiDatasetCfg = _.merge(globalPBIDatasetCfg, envPBIDatasetCfg);
        let entityCfg = _.merge(globalEntityCfg, envEntityCfg);
        
        let baseS4HEntityArray = entityCfg.s4h.entities;

        // Object.keys(entityCfg).forEach(function(key) {
        //     if (entityCfg[key].base_schema_name) {
        //         baseEntityArray = baseEntityArray.concat(entityCfg[key].entities);
        //     }
        // });

        checkS4HExtractionExists(baseS4HEntityArray);

        checkNoDuplicateEntityId(entityCfg);

        checkTargetTableExists(entityCfg);
    
    } catch (e) {
        // console.error(e.message, e.object);

        throw 'Validation Error: ' + e.message + ': ' + JSON.stringify(e.message, null, 2);
    }


}

function checkS4HExtractionExists (baseS4HEntityArray) {
    const dir = './xu-config/extractions';
    const files = fs.readdirSync(dir);
    let missingExtractions = baseS4HEntityArray.filter(e => files.indexOf(e.entity_name) === -1);

    // throw Exception
    throw new Exception('Missing S4H Extraction(s)', missingExtractions);
    // console.error('Missing S4H Extraction', missingExtractions);
}


function checkNoDuplicateEntityId (entityCfg) {

}

function checkTargetTableExists (entityCfg) {
    const dir = '../../../synapse-dwh/syndw_xxxx_sls_d_euw_001';
    
    
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