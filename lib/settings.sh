#! /Users/Howi/bin/bash

#  /==================================================  #
# /=--------------------------------------------------= #
# =----------------------------------------------------= #
#                      Settings.js                       #
# ====================================================== #
sett () {
    # creating the settings.js
    echo "--- Settings.js ---"
    fn="settings.js"
    fp="./server/config/"
    curr_path=$fp$fn
    echo $curr_path

    declare port=$1
    declare db_name=$2
    echo "module.exports = { port: $port, db: \"$db_name\" };" >> "$curr_path"
}