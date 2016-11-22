const path = require('path');

const Dog = require('./../controllers/dog.js');
const Cat = require('./../controllers/cat.js');

module.exports = (app) => {
    app.get('/', (req, res) => {
          res.send('<h1>hello example</h1>')
    })

    //Start Model Dog
    app.get('/dogs', (req, res) => {
        Dog.index(req, res);
    })
    app.get('/dogs/:id', (req, res) => {
        Dog.show(req, res);
    })
    app.post('/dogs', (req, res) => {
        Dog.create(req, res);
    })
    app.put('/dogs/:id', (req, res) => {
        Dog.update(req, res);
    })
    app.delete('/dogs/:id', (req, res) => {
        Dog.destroy(req, res);
    })
    //End Model Dog

    //Start Model Cat
    app.get('/cats', (req, res) => {
        Cat.index(req, res);
    })
    app.get('/cats/:id', (req, res) => {
        Cat.show(req, res);
    })
    app.post('/cats', (req, res) => {
        Cat.create(req, res);
    })
    app.put('/cats/:id', (req, res) => {
        Cat.update(req, res);
    })
    app.delete('/cats/:id', (req, res) => {
        Cat.destroy(req, res);
    })
    //End Model Cat
}
