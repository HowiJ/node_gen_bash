'use strict';
const mongoose = require('mongoose');
const Dog = mongoose.model('Dog')

module.exports = (function () {
    return {
        index: (req, res) => {
            Dog.find((err, data)=>{
                if (err) { console.log(err); res.json(err); } else {
                    res.json(data);
                }
            })
        },
        show: (req, res) => {
            Dog.findOne({_id:req.params.id}, (err, data)=> {
                if (err) { console.log(err); res.json(err); } else {
                    res.json(data);
                }
            })
        },
        create: (req, res) => {
            const dog = new Dog(req.body);
            dog.save((err) => {
                if (err) { console.log(err); res.json(err); } else {
                    res.redirect('/dogs');
                }
            })
        },
        update: (req, res) => {
            Dog.findOne({_id:req.params.id}, (err, data)=> {
                for (let i in req.body) {
                    if (data[i] && data[i]!=req.body[i]) {
                        data[i] = req.body[i];
                    }
                }
                data.save( (err) => {
                    if (err) { console.log(err); res.json(err); } else {
                        res.redirect('/dogs');
                    }
                })
            })
        },
        destroy: (req, res) => {
            Dog.findOne({_id:req.params.id}, (err, data)=> {
                if (err) { console.log(err); res.json(err); } else {
                    Dog.remove({_id:req.params.id}, (err) => {
                        if (err) { console.log(err); res.json(err); } else {
                            res.redirect('/dogs');
                        }
                    });
                }
            })
        }
    }
}())
