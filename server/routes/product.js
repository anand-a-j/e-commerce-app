const express = require("express");
const productRouter = express.Router();
const { Product } = require("../models/product");
const auth = require("../middleware/auth");

// fetch products based on category
productRouter.get("/api/products/", auth, async (req, res) => {
    try {
        console.log(req.query.category);
        const products = await Product.find({});
        console.log(res.products);
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// fetch products based on search query
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
        
        const products = await Product.find({
         name: {$regex: req.params.name, $options: "i"},
         
        });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;