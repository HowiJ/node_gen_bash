#! /Users/Howi/bin/bash
#  /==================================================  #
# /=--------------------------------------------------= #
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