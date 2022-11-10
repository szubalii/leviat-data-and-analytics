const fs = require('fs');
const _ = require('lodash');

function getDestinationFile (filePath) {
    try {
        return require(filePath);
    }
    catch (e) {
        console.log('##[warning] destination.json file does not exist: ' + e);
    }
}

function updateExtractionDestinationFiles () {
    const dir = __dirname + '/../extractions';
    const extractionFolderNames = fs.readdirSync(dir);
    const genericDest = require('./generic-xu-extraction-destination.json');

    console.log('Extraction destination.json files will be written in: ' + dir);


    extractionFolderNames.forEach( function (extractionFolderName) {

        let filePath = dir + '/' + extractionFolderName + '/destination.json';
        let dest = getDestinationFile(filePath);
        let customNameObject = {
            nameGenerator: {
                customName: extractionFolderName
            },
            internalSettings: {
                nameGenerator: {
                    customName: extractionFolderName
                }
            }
            //folderPath: extractionFolderName + "\/#{ DateTime.Now.ToString(\"yyyy\/MM\/dd\") }#"
        };

        if (dest) {
            dest = _.merge(dest, genericDest, customNameObject);
            console.log('Write new destination.json file for: ' + extractionFolderName);
    
            fs.writeFileSync(filePath, JSON.stringify(dest, null, '\t'));
        }
    });
}

module.exports = updateExtractionDestinationFiles();