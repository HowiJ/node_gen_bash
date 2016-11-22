'use strict';
const mongoose = require('mongoose');
const Cat = mongoose.model('Cat')

module.exports = (function () {
    return {
        index: (req, res) => {
            Cat.find((err, data)=>{
                if (err) { console.log(err); res.json(err); } else {
                    res.json(data);
                }
            })
        },
        show: (req, res) => {
            Cat.findOne({_id:req.params.id}, (err, data)=> {
                if (err) { console.log(err); res.json(err); } else {
                    res.json(data);
                }
            })
        },
        create: (req, res) => {
            const cat = new Cat(req.body);
            cat.save((err) => {
                if (err) { console.log(err); res.json(err); } else {
                    res.redirect('/cats');
                }
            })
        },
        update: (req, res) => {
            Cat.findOne({_id:req.params.id}, (err, data)=> {
                for (let i in req.body) {
                    if (data[i] && data[i]!=req.body[i]) {
                        data[i] = req.body[i];
                    }
                }
                data.save( (err) => {
                    if (err) { console.log(err); res.json(err); } else {
                        res.redirect('/cats');
                    }
                })
            })
        },
        destroy: (req, res) => {
            Cat.findOne({_id:req.params.id}, (err, data)=> {
                if (err) { console.log(err); res.json(err); } else {
                    Cat.remove({_id:req.params.id}, (err) => {
                        if (err) { console.log(err); res.json(err); } else {
                            res.redirect('/cats');
                        }
                    });
                }
            })
        }
    }
}())
