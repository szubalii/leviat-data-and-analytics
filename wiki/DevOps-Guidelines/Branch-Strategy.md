# Branch Strategy

When you have many people collaborating in a repository, the number and names of branches can quickly get out of control. Hierarchical branch folders is an effective way to tame the chaos. Azure DevOps Services, TFS, and Visual Studio treat `/` as a folder separator and will automatically collapse folders by default. This way, you don't have to wade through every single branch to find the one you're looking for. You don't have to rely on everyone to get it right, either. Azure Repos and TFS can enforce the correct use of branch folders.

The following branch strategy is in place.

#### Development branches
`{branch_type}/{user_name}/{friendly_name}`

`{branch_type}` can be one of the following  
- `feature`  changes that are expected to be deployed to `main` branch
- `users`  changes for testing purposes not required to be deployed to `main` branch
- `hotfix`  changes that are deployed directly to `prod` branch and later on are deployed back to `main` and `qas`

`{user_name}` the name of one of the development team members and acting as the creator and owner of the branch, for example: `mpors`   

`{friendly_name}` a fitting name of the feature branch that describes its topic and relation to the user story  

#### Environment branches
These branches should correspond to what is deployed to their corresponding environments.   
- `main`  linked to TEST environment
- `qas`   linked to QAS environment
- `prod`  linked to PROD environment


#### Release branches  
`release/*`