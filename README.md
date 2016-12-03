Node Server Creator (nsc.sh) (nodesc)
===============
### Description:
This is a node server generator built as a bash script. It will generate a fully modularized Node based back-end codebase with basic CRUD operations.
Currently only supports MongoDB as the database.

### Installation:
* `npm install -g nodesc`

### Usage:
1. Run the script. (If you have something after the script, it will take it as the folder name)
 * Use folderdirectory/script.sh 
  * (IE: `nsc`) 
  * (IE: `nsc foldername`)
  * (IE: `nsc foldername portnumber`)
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
* If you wish to use the script directly, you might have to use chmod to allow access and ability to run the script.
 * `chmod +x nsc.sh` works (just need to make the script executable)

### Commands:
`nsc <foldername> <port>`__
        - or - 
`nodesc <foldername> <port>`__
* the foldername and port are optional since it will ask you if you dont have it.

### Resources:
Npm     : https://www.npmjs.com/package/nodesc __
Github  : https://github.com/HowiJ/node_gen_bash


###### Made By: <i>Howard Jiang</i>

 

Copyright (c) 2004-2010 by Internet Systems Consortium, Inc. ("ISC") 
Copyright (c) 1995-2003 by Internet Software Consortium

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL ISC BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.