const { exec } = require('child_process');
// const xuPrefix;
const dir = __dirname + '..\\extractions';

// Run comma separated list of extraction names
function runExtractions(xuPrefix, extractionNames) {
  extractionNames.split(',').forEach((extractionName) => runExtraction(xuPrefix, extractionName));
}

// Run single extraction
function runExtraction(xuPrefix, extractionName) {
  let command = getExtractionCommand(xuPrefix, extractionName);
  
  console.log('Run extraction ' + extractionName);

  exec(command, (error, stdout, stderr) => {

  });
}

// Get the Xtract Universal command to run a specific extraction
function getExtractionCommand(xuPrefix, extractionName) {
  let extractionType = getExtractionType(extractionName);
  let command = `C:\\"Program Files"\\XtractUniversal\\xu.exe`;
  let params = '-s localhost -p 8065 -n ' + extractionName + ' -o "preview=True"';

  switch (extractionType) {
  // Extract 10.000 rows only in case of Table extraction type
    case 'Table':
      params += ' -o "rows=10000"';
      break;
  // Add subscription suffix in case of ODP extraction type
    case 'ODP':
      params += ' -o "subscriptionSuffix=' + xuPrefix + '"';
      break;
    default:
      console.log('Unsupported update mode for extraction ' + extractionName + ': ' + extractionType);
  }

  return command + ' ' + params;
}

// Read the general.json extraction file and return the extraction type (ODP or Table) 
function getExtractionType(extractionName) {
  let generalConfigFile = readExtractionConfigFile(extractionName, 'general');

  return generalConfigFile.type;
}

// Read an extraction config file for a given extraction
function readExtractionConfigFile(extractionName, configFileName) {

  let filePath = dir + '\\' + extractionName + '\\' + configFileName + '.json';
  
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