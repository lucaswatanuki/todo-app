const Item = require("../models/Item");

module.exports = {
    async store(req, res) {
        const {title} = req.body;

        const item = await Item.create({
            title,
        })

        return res.json(item);
    },

    async index(res){
        const items = await Item.find();

        return res.json(items);
    },

    async delete(){

    },
}