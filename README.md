Node Generator.sh
===============
### Description:
This is a node server generator built as a bash script. It will generate a fully modularized Node based back-end codebase with basic CRUD operations.

### Usage:
1. Change the top line (#! /Users/Howi/bin/bash) to your bash location.
 * Use which bash to find out your path.
2. Use chmod to allow access and ability to run the script.
 * chmod +x scriptfile.sh works (just need to make the script executable)
3. Run the script.
 * Use folderdirectory/script.sh (IE: ./nodegen.sh)
 * If you want, set an alias for the script.
4. After answering the questions, you'll have a new project folder.
 * DB Name will be the name of the database
 * Model Name is the name of the model (IE: Users). Note: no validations are in so best is to use capital first letter
 * Attribute name is attributes of the model such as name, age, etc.
 * Attribute type is the type of the attribute such as String, Number, Array, etc.
5. Inside that project folder, use npm install!
6. Run the server (main file is server.js)

### Notes:
* Make sure mongod is running.
* MongoDB is currently required in this version (unless you manually remove it in the created files of course).
* nodegen.sh && nodegen_clean.sh should have the same functionality. 

###### Made By: <i>Howard Jiang</i>