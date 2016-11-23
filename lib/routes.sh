#! /Users/Howi/bin/bash

 #  /==================================================  #
# /=--------------------------------------------------= #
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
    echo '    '"app.get('/', (req, res) => {" >> "$curr_path"
    echo '          '"res.send('<h1>hello $folder_name</h1>')" >> "$curr_path"
    echo '    '"})" >> "$curr_path"
    for i in "${!model_names[@]}"; do
        echo "" >> "$curr_path"
        echo '    '"//Start Model ${model_names[$i]}" >> "$curr_path"
        echo '    '"app.get('/${model_names[$i],,}s', (req, res) => {" >> "$curr_path"
        echo '        '"${model_names[$i]}.index(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"
        echo '    '"app.get('/${model_names[$i],,}s/:id', (req, res) => {" >> "$curr_path"
        echo '        '"${model_names[$i]}.show(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"
        echo '    '"app.post('/${model_names[$i],,}s', (req, res) => {" >> "$curr_path"
        echo '        '"${model_names[$i]}.create(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"
        echo '    '"app.put('/${model_names[$i],,}s/:id', (req, res) => {" >> "$curr_path"
        echo '        '"${model_names[$i]}.update(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"
        echo '    '"app.delete('/${model_names[$i],,}s/:id', (req, res) => {" >> "$curr_path"
        echo '        '"${model_names[$i]}.destroy(req, res);" >> "$curr_path"
        echo '    '"})" >> "$curr_path"
        echo '    '"//End Model ${model_names[$i]}" >> "$curr_path"
    done
    echo "}" >> "$curr_path"
}