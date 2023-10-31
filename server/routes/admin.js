const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin');
const {Product} = require('../models/product');

// Add Product
adminRouter.post('/admin/add-product', admin, async (req, res) => {
   try{
     const {name, description, images, quantity,price, category} = req.body;
     let product = new Product({
        name,
        description,
        images,
        quantity,
        price,
        category,
     });

   // Saving  to database
   product = await product.save();
   res.json(product);
   } catch(err){
       console.log("500 err saving to database");
       res.status(500).json({ err: err.message });
   }
});

module.exports = adminRouter;
