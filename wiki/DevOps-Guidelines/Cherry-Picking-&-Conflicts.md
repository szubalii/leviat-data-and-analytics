# Cherry Picking & Conflicts

In case conflicts happen that need to be resolved locally, use the following step-by-step process:

1. Create a new branch as copy of the branch you wish to merge to
2. Use Git Graph extension for Visual Studio Code and filter for the branch you wish to merge into to
3. Search for the PR you wish to cherry pick.
4. Use the context menu to cherry pick the selected PR and enable 'Record Origin'
5. Resolve the conflicts in Visual Studio Code
6. Commit all changes
7. Create a new PR from the new branch from step 1 into your required branch.
