const mongoose = require("mongoose");

const ItemSchema = new mongoose.Schema({
    title: String,
    done: Boolean
})

module.exports = mongoose.model("Item", ItemSchema);