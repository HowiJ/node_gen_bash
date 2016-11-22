const mongoose    = require('mongoose');
const path        = require('path');
const fs          = require('fs');

const server      = 'mongodb://localhost/';
const database    = require('./settings.js').db;
mongoose.connect(server+database);

const models_path = path.join(__dirname, './../models');
fs.readdirSync(models_path).forEach(function(file) {
    if( file.indexOf('.js') >= 0 ) {
        require(models_path + '/' + file);
    }
})
