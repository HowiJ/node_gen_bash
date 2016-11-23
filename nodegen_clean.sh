#! /Users/Howi/bin/bash
# Makes package.json

declare pwd
declare folder_name

pwd=`pwd`

# All of the other files that we use for file creation
source "$pwd/lib/package.sh"
source "$pwd/lib/settings.sh"
source "$pwd/lib/server.sh"
source "$pwd/lib/mongoose.sh"
source "$pwd/lib/model.sh"
source "$pwd/lib/routes.sh"
source "$pwd/lib/controllers.sh"

function main() {
    # Check if the folder exists or not
    if [ -d "$folder_name" ]; then
        # Folder exists
        echo "Folder already exists. Please delete it or use another name"
    else
        # ----- Initializing -----
        echo "Making project: $folder_name"
        mkdir "$folder_name"
        # Change into that directory
        cd $folder_name
        # Port Number & Database Name
        echo "_______________________________________"
        printf "Port (8000): "
        read port
        if [ -z $port ]; then
            port=8000
        fi
        printf "DB Name: "
        read db_name

        while [ -z $db_name ]; do
            echo "DB Name cannot be empty or null."
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
                # Read Attribute Name
                printf "Attribute Name (-1 to exit): "
                read attr_name
                while [ ! "$attr_name" == "-1" ]; do
                    # Keep querying while it's empty'
                    while [ -z "$attr_name" ]; do
                        echo "Attribute name cannot be empty or null."
                        printf "Attribute Name (-1 to exit): "
                        read attr_name
                    done
                    models+=("$attr_name")
                    # Attribute Type
                    printf "Attribute Type: "
                    read attr_type
                    while [ -z "$attr_type" ]; do
                        echo "Attribute type cannot be empty or null."
                        printf "Attribute Type: "
                        read attr_type
                    done
                    models+=("$attr_type")
                    echo ""
                    # Ask for Model Name
                    printf "Attribute Name (-1 to exit): "
                    read attr_name
                done
                # We're finished with the current model so we add an ending char
                models+=(0)
                echo "_______________________________________"
            else
                # If model name is empty or null
                echo "model_name cannot be empty or null."
            fi
            # Query for the name
            printf "Please enter model name (-1 to exit): "
            read model_name
        done

        #  /==================================================  #
        # /=--------------------------------------------------= #
        # =----------------------------------------------------= #
        #                   Structure Creation                   #
        # ====================================================== #
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
    fi
}

#  /==================================================  #
# /=--------------------------------------------------= #
# =----------------------------------------------------= #
#                    Setup Variables                     #
# ====================================================== #
# If folder exists, lets delete it.
echo "--- Generator ---"
printf "Folder Name: "

read folder_name

main
