Node Server Creator (nsc.sh) (nodesc)
===============
### Description:
This is a node server generator built as a bash script. It will generate a fully modularized Node based back-end codebase with basic CRUD operations.
Currently only supports MongoDB as the database.

### Installation:
* `npm install -g nodesc`

### Usage:
1. Use chmod to allow access and ability to run the script.
 * `chmod +x nsc.sh` works (just need to make the script executable)
2. Run the script. (If you have something after the script, it will take it as the folder name)
 * Use folderdirectory/script.sh 
  * (IE: `./nsc.sh`) 
  * (IE: `./nsc.sh foldername`)
  * (IE: `./nsc.sh foldername portnumber`)
 * If you want, set an alias for the script.
3. After answering the questions, you'll have a new project folder.
 * DB Name will be the name of the database
 * Model Name is the name of the model (IE: Users). Note: no validations are in so best is to use capital first letter
 * Attribute name is attributes of the model such as name, age, etc.
 * Attribute type is the type of the attribute such as String, Number, Array, etc.
4. Inside that project folder, use `npm install`!
5. Run the server (main file is server.js)

### Notes:
* Make sure mongod is running.
* MongoDB is currently required in this version (unless you manually remove it in the created files of course).
* nsc.sh && nsc_clean.sh should have the same functionality. 
* You might need to change the top line (#! /bin/bash) to your bash location if it doesn't work.
 * Use `which bash` to find out your path.

### Commands:
`nsc <foldername> <port>`
`nodesc <foldername> <port>`
* the foldername and port are optional since it will ask you if you dont have it.


###### Made By: <i>Howard Jiang</i>