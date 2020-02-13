const Item = require("../models/Item");

module.exports = {
    async store(req, res) {
        const {title, done} = req.body;

        const item = await Item.create({
            title,
            done,
        })

        return res.json(item);
    },

    async index(req, res){
        const items = await Item.find();

        return res.json(items);
    },

    async delete(){

    },
}