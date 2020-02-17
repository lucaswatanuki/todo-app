const express = require('express');
const routes = express.Router();

const ItemController = require('./controllers/ItemController');

routes.get('/item', ItemController.index);
routes.post('/item', ItemController.store);
routes.put('/item', ItemController.update);
routes.delete('/item', ItemController.delete);

module.exports = routes;