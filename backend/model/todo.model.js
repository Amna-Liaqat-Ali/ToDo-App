const mongoose = require('mongoose');
const UserModel=require('../model/user.model');

const todoSchema = new mongoose.Schema({
    //id from user model to refer user
    userId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:UserModel.modelName
    },
  title: {
    type: String,
    required: true,
  },
  desc: {
    type: String,
    required: true,
  }
});

//collections
const todoModel = mongoose.model('ToDo', todoSchema);

module.exports = todoModel;