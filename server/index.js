console.log("Node js currently running...");

// Imports from packages
const express = require('express');
const mongoose = require('mongoose');

// Imports from other files
const authRouter = require('./routes/auth');

// Init
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://anandaj:%40nAnd2001@cluster0.0tprisw.mongodb.net/?retryWrites=true&w=majority"

// Middleware - act as middle man between client and sever
// Client -> Middleware -> Sever-> Client
app.use(express.json()); 
app.use(authRouter);

// Connection to mongoose
mongoose.connect(DB).then(()=>{
  console.log("MongoDB Connection Successful");
}).catch(e =>{
  console.log(e);
})

// creating an api
app.listen(PORT,() => {
    console.log(`connect at port ${PORT} checked`);
});


// GET function sample
// https//:IPADDRESS/hello-world
app.get('/hello-world',(request,  response)=>{
  response.json({dev:"Anand A J"});
})
