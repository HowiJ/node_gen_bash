const mongoose        = require('mongoose');
const Schema          = mongoose.Schema;

const CatSchema  = new Schema({
    "name":{ "type" : "String" },
    "age":{ "type" : "Number" },
    "type":{ "type" : "String" }
})
mongoose.model('Cat', CatSchema)
