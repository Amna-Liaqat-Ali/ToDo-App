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
userSchema.pre('save', async function (next) {
  try {
    // hash only if password is new or modified
    if (!this.isModified("password")) return next();

    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt); 

    next();
  } catch (error) {
    next(error);
  }
});

//compare passwords for login
userSchema.methods.comparePassword=async function(userPassword){
  try {
    const isMatch=await bcrypt.compare(userPassword,this.password);
    return isMatch;
  } catch (error) {
   throw error; 
  }
}

//collections
const UserModel = mongoose.model('User', userSchema);

module.exports = UserModel;