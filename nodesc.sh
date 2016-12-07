#! /usr/local/bin/bash
# Makes package.json

declare folder_name
# All of the other files that we use for file creation

# =----------------------------------------------------= #
#                      Package.json                      #
# ====================================================== #
pckg () {
    echo "--- Package.json ---"
    #variables
    fn="package.json"
    fp="./"
    curr_path=$fp$fn
    echo $curr_path
    # -------------------- File Contents Below -------------------- #
    echo "{" >> "$curr_path"
    echo '    '"\"dependencies\": {" >> "$curr_path"
    echo '        '"\"express\": \"^4.14.0\"," >> "$curr_path"
    echo '        '"\"body-parser\": \"^1.15.2\"," >> "$curr_path"
    echo '        '"\"moment\": \"^2.15.2\"," >> "$curr_path"
    echo '        '"\"mongoose\": \"^4.6.6\"" >> "$curr_path"
    echo '    '"}" >> "$curr_path"
    echo "}" >> "$curr_path"
    npm init -y
}

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

# =----------------------------------------------------= #
#                       Server.js                        #
# ====================================================== #
srvr () {
    declare folder_name=$1
    # creating the server.js
    echo "--- Server.js ---"
    #variables
    fn="server.js"
    fp="./"
    curr_path=$fp$fn
    echo $curr_path

    # Creating the settings file

    # -------------------- File Contents Below -------------------- #
    echo "const express    = require('express');" >> "$curr_path"
    echo "const bodyParser = require('body-parser');" >> "$curr_path"
    echo "const mongoose   = require('mongoose');" >> "$curr_path"
    echo "const moment     = require('moment');" >> "$curr_path"
    echo "const path       = require('path');" >> "$curr_path"
    echo "const port       = require(path.join(__dirname,\"./server/config/settings.js\")).port;" >> "$curr_path"
    echo "const app        = express();" >> "$curr_path"
    echo "" >> "$curr_path"
    echo "app.use(bodyParser.urlencoded({extended:true}))" >> "$curr_path"
    echo "app.use(bodyParser.json())" >> "$curr_path"
    echo "app.use(express.static(path.join(__dirname, './client')))" >> "$curr_path"
    echo "" >> "$curr_path"
    echo "require(path.join(__dirname, './server/config/mongoose.js'));" >> "$curr_path"
    echo "" >> "$curr_path"
    echo "require(path.join(__dirname, './server/config/routes.js'))(app);" >> "$curr_path"
    echo "" >> "$curr_path"
    echo "app.listen(port, function() {" >> "$curr_path"
    echo '    '"console.log(moment().format('MMMM Do, YYYY : h:mm:ss a'));" >> "$curr_path"
    echo '    '"console.log('$folder_name listening on port '+port);" >> "$curr_path"
    echo "})" >> "$curr_path"

    echo "Created server.js"
}

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

# =----------------------------------------------------= #
#                         Models                         #
# ====================================================== #
model () {
    declare -a models=("$@")
    fp="./server/models/"

    mode=0
    for i in "${!models[@]}"; do
        if [ "$mode" == "0" ]; then
            ((mode++))
            mname=${models[$i]}
            fname=${models[$i],,}
            # echo $mname
            echo "const mongoose        = require('mongoose');" >> $fp$fname".js"
            echo "const Schema          = mongoose.Schema;" >> $fp$fname".js"
            echo "" >> $fp$fname".js"
            echo "const ${mname}Schema  = new Schema({" >> $fp$fname".js"
            model_names+=($mname)
        elif [ "${models[$i]}" == "0" ]; then
            mode=0
            sed '$ s/.$//' $fp$fname".js"
            sed -i '' '$ s/.$//' $fp$fname".js"
            echo "})" >> $fp$fname".js"
            echo "mongoose.model('${mname}', ${mname}Schema)" >> $fp$fname".js"
            ls $fp
        elif [ "$mode" == "1" ]; then
            ((mode++))
            printf '    '"\"${models[$i]}\":" >> $fp$fname".js"
        elif [ "$mode" == "2" ]; then
            mode=1
            echo "{ \"type\" : \"${models[$i]}\" }," >> $fp$fname".js"
        fi
    done
}

# =----------------------------------------------------= #
#                       Routes.js                        #
# ====================================================== #

rout () {
    echo "--- Routes.js ---"
    declare -a model_names=("$@") 

    #variables
    fn="routes.js"
    fp="./server/config/"
    curr_path=$fp$fn
    echo $curr_path

    # -------------------- File Contents Below -------------------- #
    echo "const path = require('path');" >> "$curr_path"
    echo "" >> "$curr_path"
    for i in "${!model_names[@]}"; do
        touch "./server/controllers/${model_names[$i],,}.js"
        echo "const ${model_names[$i]} = require('./../controllers/${model_names[$i],,}.js');" >> "$curr_path"
    done
    echo "" >> "$curr_path"
    echo "module.exports = (app) => {" >> "$curr_path"
    echo '    '"// This route is just for the default welcome page." >> "$curr_path"
    echo '    '"app.get('/', (req, res) => {" >> "$curr_path"
    echo '        '"// Default Welcome Message." >> "$curr_path"
    echo '        '"res.send('<h1>Hey there!</h1><h3>Project: $folder_name</h3><h4>A few things to know....</h4><ul><li>Your server is up and running...</li><li>Routes are restful and set up...</li><li>Controllers are set up per model...</li></ul><p><i>Made by Howard Jiang (github.com/HowiJ/node_gen_bash)</i></p>')" >> "$curr_path"
    echo '    '"})" >> "$curr_path"
    for i in "${!model_names[@]}"; do
        echo "" >> "$curr_path"
        echo '    '"//Start Model ${model_names[$i]}" >> "$curr_path"

        # App Get (All)
        if [ "${model_names[$i]: -1}" == "s" ]; then
        echo '    '"app.get('/${model_names[$i],,}', (req, res) => {" >> "$curr_path"
        else
        echo '    '"app.get('/${model_names[$i],,}s', (req, res) => {" >> "$curr_path"
        fi
        echo '        '"${model_names[$i]}.index(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"

        # App Get (Show)
        if [ "${model_names[$i]: -1}" == "s" ]; then
        echo '    '"app.get('/${model_names[$i],,}/:id', (req, res) => {" >> "$curr_path"
        else
        echo '    '"app.get('/${model_names[$i],,}s/:id', (req, res) => {" >> "$curr_path"
        fi
        echo '        '"${model_names[$i]}.show(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"

        # App Post (Creation)
        if [ "${model_names[$i]: -1}" == "s" ]; then
        echo '    '"app.post('/${model_names[$i],,}', (req, res) => {" >> "$curr_path"
        else
        echo '    '"app.post('/${model_names[$i],,}s', (req, res) => {" >> "$curr_path"
        fi
        echo '        '"${model_names[$i]}.create(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"

        # App Put (Update)
        if [ "${model_names[$i]: -1}" == "s" ]; then
        echo '    '"app.put('/${model_names[$i],,}/:id', (req, res) => {" >> "$curr_path"
        else
        echo '    '"app.put('/${model_names[$i],,}s/:id', (req, res) => {" >> "$curr_path"
        fi
        echo '        '"${model_names[$i]}.update(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"

        # App Delete (Destroy)
        if [ "${model_names[$i]: -1}" == "s" ]; then
        echo '    '"app.delete('/${model_names[$i],,}/:id', (req, res) => {" >> "$curr_path"
        else
        echo '    '"app.delete('/${model_names[$i],,}s/:id', (req, res) => {" >> "$curr_path"
        fi
        echo '        '"${model_names[$i]}.destroy(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"
        echo '    '"//End Model ${model_names[$i]}" >> "$curr_path"
    done
    echo "}" >> "$curr_path"
}
# =----------------------------------------------------= #
#                      Controllers                       #
# ====================================================== #

ctrl () {
    declare -a model_names=("$@") 

    echo "--- Controllers ---"
    #variables
    fn="controllers.js"
    fp="./server/controllers/"
    curr_path=$fp$fn
    echo $curr_path
    # -------------------- File Contents Below -------------------- #
    for i in ${!model_names[@]}; do
        fname="${model_names[$i]}.js"
        echo $fp$fname
        echo "'use strict';" >> $fp$fname
        echo "const mongoose = require('mongoose');" >> $fp$fname
        echo "const ${model_names[$i]} = mongoose.model('${model_names[$i]}')" >> $fp$fname
        echo "" >> $fp$fname
        echo "module.exports = (function () {" >> $fp$fname
        echo '    '"return {" >> $fp$fname
        echo '        '"index: (req, res) => {" >> $fp$fname
        echo '            '"${model_names[$i]}.find((err, data)=>{" >> $fp$fname
        echo '                '"if (err) { console.log(err); res.json(err); } else {" >> $fp$fname
        echo '                    '"res.json(data);" >> $fp$fname
        echo '                '"}" >> $fp$fname
        echo '            '"})" >> $fp$fname
        echo '        '"}," >> $fp$fname
        echo '        '"show: (req, res) => {" >> $fp$fname
        echo '            '"${model_names[$i]}.findOne({_id:req.params.id}, (err, data)=> {" >> $fp$fname
        echo '                '"if (err) { console.log(err); res.json(err); } else {" >> $fp$fname
        echo '                    '"res.json(data);" >> $fp$fname
        echo '                '"}" >> $fp$fname
        echo '            '"})" >> $fp$fname
        echo '        '"}," >> $fp$fname
        echo '        '"create: (req, res) => {" >> $fp$fname
        echo '            '"const new_${model_names[$i],,} = new ${model_names[$i]}(req.body);" >> $fp$fname
        echo '            '"new_${model_names[$i],,}.save((err) => {" >> $fp$fname
        echo '                '"if (err) { console.log(err); res.json(err); } else {" >> $fp$fname
        echo '                    '"res.redirect('/${model_names[$i],,}s');" >> $fp$fname
        echo '                '"}" >> $fp$fname
        echo '            '"})" >> $fp$fname
        echo '        '"}," >> $fp$fname
        echo '        '"update: (req, res) => {" >> $fp$fname
        echo '            '"${model_names[$i]}.findOne({_id:req.params.id}, (err, data)=> {" >> $fp$fname
        echo '                '"for (let i in req.body) {" >> $fp$fname
        echo '                    '"if (data[i] && data[i]!=req.body[i]) {" >> $fp$fname
        echo '                        '"data[i] = req.body[i];" >> $fp$fname
        echo '                    '"}" >> $fp$fname
        echo '                '"}" >> $fp$fname
        echo '                '"data.save( (err) => {" >> $fp$fname
        echo '                    '"if (err) { console.log(err); res.json(err); } else {" >> $fp$fname
        echo '                        '"res.redirect('/${model_names[$i],,}s');" >> $fp$fname
        echo '                    '"}" >> $fp$fname
        echo '                '"})" >> $fp$fname
        echo '            '"})" >> $fp$fname
        echo '        '"}," >> $fp$fname
        echo '        '"destroy: (req, res) => {" >> $fp$fname
        echo '            '"${model_names[$i]}.findOne({_id:req.params.id}, (err, data)=> {" >> $fp$fname
        echo '                '"if (err) { console.log(err); res.json(err); } else {" >> $fp$fname
        echo '                    '"${model_names[$i]}.remove({_id:req.params.id}, (err) => {" >> $fp$fname
        echo '                        '"if (err) { console.log(err); res.json(err); } else {" >> $fp$fname
        echo '                            '"res.redirect('/${model_names[$i],,}s');" >> $fp$fname
        echo '                        '"}" >> $fp$fname
        echo '                    '"});" >> $fp$fname
        echo '                '"}" >> $fp$fname
        echo '            '"})" >> $fp$fname
        echo '        '"}" >> $fp$fname
        echo '    '"}" >> $fp$fname
        echo "}())" >> $fp$fname
    done
}
# Colors
declare NC='\033[0m'
declare RED='\033[0;31m'
declare GREEN='\033[0;32m'
declare PURPLE='\033[0;35m'
declare CYAN='\033[0;36m'
declare GRAY='\033[1;30m'

function main() {
    # ----- Initializing -----
    # Port Number & Database Name
    printf "Port (8000): "
    if [ ! -z $1 ]; then
        port=$1
        echo "$port"
    else
        read port
    fi
    if [ -z $port ]; then
        echo -e "${RED}WARN: Port defaulted to 8000.${NC}"
        port=8000
    fi
    printf "DB Name: "
    read db_name

    while [ -z $db_name ]; do
        echo -e "${RED}ERR: DB Name cannot be empty or null.${NC}"
        printf "DB Name: "
        read db_name
    done
    # =----------------------------------------------------= #
    #                         Models                         #
    # ====================================================== #
    declare -a models=()
    declare -a model_names=()

    models=()
    # Read Model Name
    echo "_______________________________________"
    printf "Please enter model name (-1 to exit): "
    read model_name
    while [ ! "$model_name" == "-1" ]; do
        if [ ! -z "$model_name" ]; then
            # Add Model Name to Array
            models+=("$model_name")
            # New Line for each attr
            echo ""
            # Read Attribute Name
            printf "Attribute Name (-1 to exit): "
            read attr_name
            while [ ! "$attr_name" == "-1" ]; do
                # Keep querying while it's empty'
                while [ -z "$attr_name" ]; do
                    echo -e "${RED}ERR: Attribute name cannot be empty or null.${NC}"
                    printf "Attribute Name (-1 to exit): "
                    read attr_name
                done
                models+=("$attr_name")
                # Attribute Type
                printf "Attribute Type: "
                read attr_type
                while [ -z "$attr_type" ]; do
                    echo -e "${RED}Attribute type cannot be empty or null.${NC}"
                    printf "Attribute Type: "
                    read attr_type
                done
                models+=("$attr_type")
                echo ""
                # Ask for Model Name
                printf "Attribute Name (-1 to exit):"
                read attr_name
            done
            # We're finished with the current model so we add an ending char
            models+=(0)
            echo "_______________________________________"
        else
            # If model name is empty or null
            echo -e "${RED} ERR: model_name cannot be empty or null.${NC}"
        fi
        # Query for the name
        printf "Please enter model name (-1 to exit): "
        read model_name
    done

    # =----------------------------------------------------= #
    #                   Structure Creation                   #
    # ====================================================== #
    ## Create the project Folder
    echo -e "Making project: ${GRAY}$folder_name${NC}"
    mkdir "$folder_name"
    # Change into that directory
    cd $folder_name

    # Structure Creation
    touch server.js
    mkdir client

    mkdir server
    mkdir server/config
    mkdir server/controllers
    mkdir server/models

    touch server/config/settings.js

    echo "--------------------------------------------"
    echo "-------------- Creating Files --------------"
    echo "--------------------------------------------"
    # Package Function
    pckg "$folder_name"
    # Server Function
    srvr "$folder_name"
    # Settings Function
    sett "$port" "$db_name"
    # Mongoose Function
    mongoo
    # Models Function
    model "${models[@]}"
    # Routes Function 
    rout "${model_names[@]}"
    # Controller Function 
    ctrl "${model_names[@]}"
}

# =----------------------------------------------------= #
#                    Setup Variables                     #
# ====================================================== #
# If folder exists, lets delete it.
declare tester="HELLO"
echo ${tester,,}
echo "--- Node Server Generator ---"
printf "Folder Name: "
if [ ! -z $1 ]; then
    folder_name=$1
    echo $folder_name
else
    read folder_name
fi

while [ -z "$folder_name" ]; do
    echo -e "${RED}ERR: Folder Name cannot be empty or null.${NC}"
    printf "Folder Name: "
    read folder_name
done
# echo $2

# Check if the folder exists or not
if [ -d "$folder_name" ]; then
    # Folder exists
    echo -e "${RED}ERR: Folder already exists. Please delete it or use another name"
else
    # Runs the main function passing in the 2nd variable entered
    main $2
fi
