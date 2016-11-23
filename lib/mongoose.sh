#! /Users/Howi/bin/bash

#  /==================================================  #
# /=--------------------------------------------------= #
# =----------------------------------------------------= #
#                      Mongoose.js                       #
# ====================================================== #

mongoo () {
    echo "--- Mongoose.js ---"
    #variables
    fn="mongoose.js"
    fp="./server/config/"
    curr_path=$fp$fn
    echo $curr_path
    # -------------------- File Contents Below -------------------- #
    echo "const mongoose    = require('mongoose');" >> "$curr_path"
    echo "const path        = require('path');" >> "$curr_path"
    echo "const fs          = require('fs');" >> "$curr_path"
    echo "" >> "$curr_path"
    echo "const server      = 'mongodb://localhost/';" >> "$curr_path"
    echo "const database    = require('./settings.js').db;" >> "$curr_path"
    echo "mongoose.connect(server+database);" >> "$curr_path"
    echo "" >> "$curr_path"
    echo "const models_path = path.join(__dirname, './../models');" >> "$curr_path"
    echo "fs.readdirSync(models_path).forEach(function(file) {" >> "$curr_path"
    echo '    '"if( file.indexOf('.js') >= 0 ) {" >> "$curr_path"
    echo '        '"require(models_path + '/' + file);" >> "$curr_path"
    echo '    '"}" >> "$curr_path"
    echo "})" >> "$curr_path"

    echo "Created mongoose.js"
}