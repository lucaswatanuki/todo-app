const express = require('express');
const routes = express.Router();

const ItemController = require('./controllers/ItemController');


routes.get('/item', ItemController.index);
routes.post('/item', ItemController.store);

module.exports = routes;