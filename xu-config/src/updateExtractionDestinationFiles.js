const fs = require('fs');
const _ = require('lodash');

function updateExtractionDestinationFiles () {
    const dir = __dirname + '/../extractions';
    const extractionFolderNames = fs.readdirSync(dir);
    const genericDest = require('./generic-xu-extraction-destination.json');

    extractionFolderNames.forEach( function (extractionFoldername) {
        try {
            let filePath = dir + '/' + extractionFoldername + '/destination.json';
            let dest = require(filePath);
            let customNameObject = {
                nameGenerator: {
                    customName: extractionFoldername
                },
                internalSettings: {
                    nameGenerator: {
                        customName: extractionFoldername
                    }
                }
                //folderPath: extractionFoldername + "\/#{ DateTime.Now.ToString(\"yyyy\/MM\/dd\") }#"
            };
                       
            dest = _.merge(dest, genericDest, customNameObject);

            fs.writeFileSync(filePath, dest);
        }
        catch (e) {

        }


    });
}

module.exports = updateExtractionDestinationFiles();