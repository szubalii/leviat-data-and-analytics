const { exec } = require('child_process');
// const xuPrefix;
const dir = __dirname + '/../extractions';


function runExtractions(xuPrefix, extractionNames) {
  extractionNames.split(',').forEach((extractionName) => runExtraction(xuPrefix, extractionName));
}

function runExtraction(xuPrefix, extractionName) {
  let command = getExtractionCommand(xuPrefix, extractionName);

  exec(command, (error, stdout, stderr) => {

  });
}

function getExtractionCommand(xuPrefix, extractionName) {
  let extractionType = getExtractionType(extractionName);
  let command = `C:\\"Program Files"\\XtractUniversal\\xu.exe`;
  let params = '-s localhost -p 8065 -n ' + extractionName + ' -o "preview=True"';

  switch (extractionType) {
    case 'Table':
      params += ' -o "rows=10000"';
      break;
    case 'ODP':
      params += ' -o "subscriptionSuffix=' + xuPrefix + '"';
      break;
    default:
      console.log('Unsupported update mode for extraction ' + extractionName + ': ' + extractionType);
  }

  return command + ' ' + params;
}

function getExtractionType(extractionName) {
  let generalConfigFile = readExtractionConfigFile(extractionName, 'general');

  return generalConfigFile.type;
}

function readExtractionConfigFile(extractionName, configFileName) {

  let filePath = dir + '/' + extractionName + '/' + configFileName + '.json';
  
  try {
    return require(filePath);
  }
  catch (e) {
    console.log('##[warning] File "' + filePath + '" does not exist: ' + e);
  }
}

module.exports = runExtractions(process.argv[2], process.argv[3])
//  {
  // console.log(extractionNames)
  // extractionNames.forEach((extractionName) => runExtraction(xuPrefix, extractionName));
// }(process.argv[2], process.argv[3]);