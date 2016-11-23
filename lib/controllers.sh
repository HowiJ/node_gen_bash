#! /Users/Howi/bin/bash

#  /==================================================  #
# /=--------------------------------------------------= #
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