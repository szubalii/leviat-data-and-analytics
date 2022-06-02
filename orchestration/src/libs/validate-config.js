const globalEntityCfg = require('../config/global/entity.json');

var _ = require('lodash');

function validateEnvConfig (env) {

    const envPBIDatasetCfg = require('../config/' + env + '/entity.json');
    let pbiDatasetCfg = _.merge(globalPBIDatasetCfg, envPBIDatasetCfg);


}

function checkExistingExtraction () {

}

function checkDuplicateEntityId () {

}

function checkExistingTargetTable () {

}




module.exports = {
    validateConfig: function () {
        validateEnvConfig(env);
    }
};