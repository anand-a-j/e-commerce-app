const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin');
const Product = require('../models/product');

// Add Product
adminRouter.post('/admin/add-product', admin, async (req, res) => {
   try{
     const {name, description, images, quantity,price, category} = req;
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
   } catch(e){
       res.status(500).json({ err: err.message });
   }
});

module.exports = adminRouter;
