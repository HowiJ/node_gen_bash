#  /==================================================  #
# /=--------------------------------------------------= #
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