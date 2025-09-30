const UserModel = require('../model/user.model');


//handles crud operations logic 
class UserService {
    //register user
  static async registerUser({ email, password }) {
    const newUser = new UserModel({ email, password });
    return await newUser.save();
  }

  //find by email if exist or not
  static async findByEmail(email) {
    return await UserModel.findOne({ email });
  }
}

module.exports = UserService;