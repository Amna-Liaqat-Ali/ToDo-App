const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.router');

const app = express();

//body parser used to read files
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// defines Routes
app.use('/', userRouter);

module.exports = app;