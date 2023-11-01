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

// rate the product
productRouter.post("/api/rate-product", auth, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId == req.user) {
                product.ratings.splice(i, 1);
                break;
            }
        }

        const ratingSchema = {
            userId: req.user,
            rating,
        };

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


module.exports = productRouter;