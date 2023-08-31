const express = require('express');
const User = require('../models/user.js');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

const authRouter = express.Router();


// SIGN UP Route
authRouter.post('/api/signup', async(req,res) => {
  /// Get the data from client
  /// post that data in the database
  /// return that data to the user
try{
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

}catch(e){
 res.status(500).json({error: e.message});
}

});

// SIGN IN Route
authRouter.post('/api/signin', async(req,res)=>{
    try{
     const {email, password} = req.body;

     const user = await User.findOne({email});
     if(!user){
        return res.status(400).json({msg:"User with this email does not exist!"});
     }

     const isMatch = await bcryptjs.compare(password, user.password);

     if(!isMatch){
        return res.status(400).json({msg:"Incorrect Password!!!"});
     }

     const token = jwt.sign({id:user._id,},"passwordKey");
     res.json({token,...user._doc});
     
    }catch(e){
      res.status(500).json({error:e.message});
    }
})

// Export this file accessing for other files
module.exports = authRouter;