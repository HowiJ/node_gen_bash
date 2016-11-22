const mongoose        = require('mongoose');
const Schema          = mongoose.Schema;

const DogSchema  = new Schema({
    "name":{ "type" : "String" },
    "age":{ "type" : "Number" },
    "type":{ "type" : "String" }
})
mongoose.model('Dog', DogSchema)
