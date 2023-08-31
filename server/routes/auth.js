const express = require('express');
const User = require('../models/user.js');
const bcryptjs = require('bcryptjs');

const authRouter = express.Router();

// SIGN UP
authRouter.post('/api/signup', async(req,res) => {
try{
 /// Get the data from client-----------------------------------------------------------------------------
  const {name,email,password} = req.body;

 // checking user already sign up
 const existingUser = await User.findOne({email});
 if(existingUser) {
    return res.status(400).json({msg:"User with same email already exist!"});
 }

// secure password
const hashedPassword = await bcryptjs.hash(password, 8);

// create user model
 let user = new User({
     email,
     password: hashedPassword,
     name
 });

 user = await user.save();
 res.json(user);
 /// post that data in the database-----------------------------------------------------------------------
 /// return that data to the user-------------------------------------------------------------------------
}catch(e){
 res.status(500).json({error: e.message});
}

});

// Export this file accessing for other files
module.exports = authRouter;