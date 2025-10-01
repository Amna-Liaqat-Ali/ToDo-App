const express = require('express');
const app = express();

// Parse JSON from request
app.use(express.json());

const userRouter = require('./routers/user.router');
app.use('/', userRouter);

module.exports = app;