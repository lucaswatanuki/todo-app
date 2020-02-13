const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const routes = require('./routes');

const app = express();

mongoose.connect('mongodb+srv://lucasw:admin@cluster0-mqscv.mongodb.net/todo?retryWrites=true&w=majority', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})

app.use(express.json());
app.use(cors());
app.use(routes);
app.listen(8080)