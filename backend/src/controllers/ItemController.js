const Item = require("../models/Item");

module.exports = {
    async store(req, res) {
        const { title, done } = req.body;

        const item = await Item.create({
            title,
            done,
        })

        return res.json(item);
    },

    async index(req, res) {
        const items = await Item.find();

        return res.json(items);
    },

    async update(req, res) {
        const { title } = req.query;

        let item = await Item.findOne({ title });

        if (!item) {
            return response.json({ message: "item not found" });
        }

        item.done = req.body.done;
        await item.save();

        return res.json(item);
    },

    async delete(req) {
        const { title } = req.query;

        let item = await Item.findOne({ title });

        if (!item) {
            return response.json({ message: "item not found" });
        }

        item.delete();
    },
}