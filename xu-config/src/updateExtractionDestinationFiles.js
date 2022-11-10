const fs = require('fs');
const _ = require('lodash');

function updateExtractionDestinationFiles () {
    const dir = __dirname + '/../extractions';
    const extractionFolderNames = fs.readdirSync(dir);
    const genericDest = require('./generic-xu-extraction-destination.json');

    console.log('Extraction destination.json files will be written in: ' + dir);


    extractionFolderNames.forEach( function (extractionFolderName) {
        try {
            let filePath = dir + '/' + extractionFolderName + '/destination.json';
            let dest = require(filePath);
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
                       
            dest = _.merge(dest, genericDest, customNameObject);

            console.log('Write new destination.json file for: ' + extractionFolderName);

            fs.writeFileSync(filePath, dest);
        }
        catch (e) {
            console.error('##[error] ' + e);
        }
    });
}

module.exports = updateExtractionDestinationFiles();