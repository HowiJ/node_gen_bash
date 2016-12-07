#  /==================================================  #
# /=--------------------------------------------------= #
# =----------------------------------------------------= #
#                         Models                         #
# ====================================================== #
model () {
    declare -a models=("$@")
    declare fname
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
            echo "" >> $fp${fname,,}".js"
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
