const fs = require('fs')

fs.readFile('./Master Data/01 DEV/entity.csv', 'utf8', (err, data) => {
    if (err) {
        console.error(err)
        return
    }

    //   let entitiesArray = [];

    let entityStringArray = data.split('\r\n');//.map(entity => {entity.);
    let headerArray = entityStringArray.shift().split(',');
    let entitiesArray = [];

    entityStringArray.map(function (entityString, index) {
        let entityObject = {};
        let entity = entityString.split('"');
        // console.log(entity.length);

        debugger;

        let entityArray = entity[0].split(',');

        if (entity.length === 3 && typeof entity[1] === "string" && typeof entity[2] === "string"){
            // console.log('entity: \n')
            // console.log(entity)
            // remove the last item
            entityArray.pop();
            // remove the first comma
            let rest = entity[2].substring(1);
            
            entityArray = entityArray.concat(entity[1], rest.split(','));
            // if(index === 0){
            //     console.log(entityArray);
            // }
        }

        headerArray.forEach(function (h, i) {
            let entityAttrValue = entityArray[i];
            if (entityAttrValue !== "") {
                if (!isNaN(parseInt(entityAttrValue))) {
                    entityAttrValue = parseInt(entityAttrValue);
                }
                entityObject[h] = entityAttrValue;
            }
        })
        
               
        entitiesArray.push(entityObject);
        
    });

    // console.log('headerArray: \n')
    // console.log(headerArray)
    // console.log('entityStringArray:\n')
    // console.log(entityStringArray)
    // console.log(entitiesArray[0])

    // console.log(JSON.stringify(entitiesArray));
})
