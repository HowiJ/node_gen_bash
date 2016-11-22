const express    = require('express');
const bodyParser = require('body-parser');
const mongoose   = require('mongoose');
const moment     = require('moment');
const path       = require('path');
const port       = require(path.join(__dirname,"./server/config/settings.js")).port;
const app        = express();

app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
app.use(express.static(path.join(__dirname, './client')))

require(path.join(__dirname, './server/config/mongoose.js'));

require(path.join(__dirname, './server/config/routes.js'))(app);

app.listen(port, function() {
    console.log(moment().format('MMMM Do, YYYY : h:mm:ss a'));
    console.log('example listening on port '+port);
})
