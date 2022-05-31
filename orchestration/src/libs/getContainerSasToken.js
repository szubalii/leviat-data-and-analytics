
const { DefaultAzureCredential } = require("@azure/identity");
const AzureStorageBlob = require("@azure/storage-blob");
const { URLBuilder } = require("@azure/core-http")

// // Create a service SAS for a blob container
// function getContainerSasUri(containerClient, sharedKeyCredential, storedPolicyName) {
//     const sasOptions = {
//         containerName: containerClient.containerName,
//         permissions: AzureStorageBlob.ContainerSASPermissions.parse("c")
//     };

//     if (storedPolicyName == null) {
//         sasOptions.startsOn = new Date();
//         sasOptions.expiresOn = new Date(new Date().valueOf() + 3600 * 1000);
//     } else {
//         sasOptions.identifier = storedPolicyName;
//     }

//     const sasToken = AzureStorageBlob.generateBlobSASQueryParameters(sasOptions, sharedKeyCredential).toString();
//     console.log(`SAS token for blob container is: ${sasToken}`);

//     return `${containerClient.url}?${sasToken}`;
// }

// Create a service SAS for a blob container
function getContainerSasToken(containerClient, azureCredential, storedPolicyName) {
    const sasOptions = {
        containerName: containerClient.containerName,
        permissions: AzureStorageBlob.ContainerSASPermissions.parse("r")
    };

    if (storedPolicyName == null) {
        sasOptions.startsOn = new Date();
        sasOptions.expiresOn = new Date(new Date().valueOf() + 3600 * 1000);
    } else {
        sasOptions.identifier = storedPolicyName;
    }
    // console.log("sasOptions:");
    // console.log(sasOptions);
    const sasToken = AzureStorageBlob.generateBlobSASQueryParameters(
        sasOptions,
        azureCredential,
        containerClient.accountName
    ).toString();
    // console.log(`SAS token for blob container is: ${sasToken}`);

    return sasToken;
}

module.exports = async function(containerUri) {//, storageAccountName){
    const storedPolicyName = null;
    const blobUri = URLBuilder.parse(containerUri);
    blobUri.setPath('');//.setPath('').toString();//`https://${storageAccountName}.blob.core.windows.net`;
    const containerClient = new AzureStorageBlob.ContainerClient(containerUri);//https://stxxxxslsdeuw001.blob.core.windows.net/orch-db')
    const blobServiceClient = new AzureStorageBlob.BlobServiceClient(blobUri.toString(), new DefaultAzureCredential());
    const userDelegationKey = await blobServiceClient.getUserDelegationKey(
        new Date(),
        new Date(new Date().valueOf() + 3600 * 1000)
    );
    // const sharedKeyCredential = new AzureStorageBlob.StorageSharedKeyCredential(storageAccountName, storageAccountKey)//'stxxxxslsdeuw001', <sasToken>);

    const sasToken = getContainerSasToken(containerClient, userDelegationKey, storedPolicyName);

    process.stdout.write(`##vso[task.setVariable variable=sasToken_OrchDB;issecret=true]${sasToken}`);
};

//Call:
//C:\Users\Michiel_Pors\source\repos\sqldb-xxxx-orchdb-d-euw-001>node -e require('./src/libs/getContainerSasToken')('https://stxxxxslsdeuw001.blob.core.windows.net/orch-db','stxxxxslsdeuw001',<sasToken>)