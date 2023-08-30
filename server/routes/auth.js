const express = require('express');

const authRouter = express.Router();

authRouter.post('/api/signup', (req,res) => {
 // Get the data from client-----------------------------------------------------------------------------
  const {name,email,password} = req.body;
  

 // post that data in the database-----------------------------------------------------------------------

 // return that data to the user-------------------------------------------------------------------------

});

// Export this file accessing for other files
module.exports = authRouter;