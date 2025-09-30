const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.router');

const app = express();

//body parser used to read files
app.use(bodyParser.json());

// defines Routes
app.use('/api/users', userRouter);

module.exports = app;