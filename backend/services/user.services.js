const UserModel = require('../model/user.model');
const jwt=require('jsonwebtoken');

//handles crud operations logic 
class UserService {
    //register user
  static async registerUser({ email, password }) {
    const newUser = new UserModel({ email, password });
    return await newUser.save();
  }

  //find by email if user exist or not for login
  static async findByEmail(email) {
    return await UserModel.findOne({ email });
  }

  //generating token after sucessful login
  static async generateToken(tokenData,secretKey,jwt_expire){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire});
  }



}

module.exports = UserService;