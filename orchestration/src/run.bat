cd ./_sqldb-xxxx-orchdb-d-euw-001/Release

node -e require('./src/libs/generate-master-data').writeMasterDataCSV('dev')
node -e require('./src/libs/getContainerSasToken')('https://stxxxxslsdeuw001.blob.core.windows.net/orch-db')