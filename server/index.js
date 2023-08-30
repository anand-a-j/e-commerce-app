console.log("Hello world");

const express = require('express');

const PORT = 3000;

const app = express();
// creating an api
app.listen(PORT,"0.0.0.0",() => {
    console.log(`connect at port ${PORT}`);
});
