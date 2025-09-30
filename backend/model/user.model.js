const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const userSchema = new mongoose.Schema({
  email: {
    type: String,
    lowercase: true,
    required: true,
    unique: true
  },
  password: {
    type: String,
    required: true,
  }
});

// hash or encrypt password before saving
userSchema.pre('save', async function () {
  try {
    var user=this;
    const salt=await (bcrypt.genSalt(10));
    const hashPass=await bcrypt.hash(user.password,salt);
  } catch (error) {
   throw error;
  }
});

//collections
const UserModel = mongoose.model('User', userSchema);

module.exports = UserModel;