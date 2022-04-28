# Bonfire.EditorQuill

A template for creating custom extensions for [Bonfire](https://bonfire.cafe/)

## How to use it
- Clone the repository on your `/forks` folder
```
cd forks
mkdir {your-extension-name}
git clone https://github.com/bonfire-networks/bonfire_editor_quill.git .
```
- Rename all the modules names to match your extension name:
    - Find & replace Bonfire.EditorQuill -> Bonfire.YourExtensionName 
    - Find & replace bonfire_editor_quill -> bonfire_your_extension_name
- Rename the `bonfire_editor_quill.exs` config file to match your extension name `bonfire_your_extension_name.exs`
- Add paths to the router if you need it. If you add paths you will need to include the route module on [bonfire-app router module](https://github.com/bonfire-networks/bonfire-app/blob/main/lib/web/router.ex#L51) 
- Add extension specific Fake functions
- Add extension specific migrations
- Add extension deps to deps.git and/or deps.hex 
- Delete the bonfire extension template git history and initiate a new .git 
    ```
    rm -rf .git
    git init    
    ```
- Create your empty extension repository on your preferred platform
- Push your local changes
    ```
      git add .
      git commit -m "first commit"
      git create -M main
      git remote add origin {your-remote-repository}
      git push -u origin main
    ```
- Add the extension on your bonfire deps.path to include it in your local development
- Add the extension on deps.git also (specifying the branch name) to allow others that do not have it in their fork to use it
- Write a meaningful readme
- TADA 🔥!

## Copyright and License

Copyright (c) 2020 Bonfire, VoxPublica, and CommonsPub Contributors

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public
License along with this program.  If not, see <https://www.gnu.org/licenses/>.
