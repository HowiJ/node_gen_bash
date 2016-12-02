#! /Users/Howi/bin/bash
# Makes package.json

declare pwd
declare folder_name
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pwd=`pwd`
echo $SOURCE
# All of the other files that we use for file creation
source "$DIR/lib/package.sh"
source "$DIR/lib/settings.sh"
source "$DIR/lib/server.sh"
source "$DIR/lib/mongoose.sh"
source "$DIR/lib/model.sh"
source "$DIR/lib/routes.sh"
source "$DIR/lib/controllers.sh"

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
        echo "_______________________________________"
        printf "Port (8000): "
        if [ ! -z $1 ]; then
            port=$1
            echo "$port"
        else
            echo "NONE"
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
                    # New Line for each attr
                    echo ""
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

        #  /==================================================  #
        # /=--------------------------------------------------= #
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

#  /==================================================  #
# /=--------------------------------------------------= #
# =----------------------------------------------------= #
#                    Setup Variables                     #
# ====================================================== #
# If folder exists, lets delete it.
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
    main $2
fi
