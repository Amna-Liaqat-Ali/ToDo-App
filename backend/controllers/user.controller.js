const UserService = require('../services/user.services');

// Handles request/response from frontend

//regsiter user
exports.register = async (req, res) => {
  try {
       console.log("Request Body:", req.body);  //for checking
    const { email, password } = req.body;


    if (!email || !password) {
      console.log("Missing email or password"); // log missing fields
      return res.status(400).json({ msg: "Email or password missing" });
    }

    // check if user already exists
    const existingUser = await UserService.findByEmail(email);
    if (existingUser) {
      return res.status(400).json({ error: "User already exists!" });
    }

    const user = await UserService.registerUser({ email, password });
    return res.status(201).json({
      status:true,
      message: "User registered successfully!",
      data: user
    });

  } catch (err) {
    console.log(err);
    return res.status(500).json({ status:false,error: err.message });
  }
};

//login
exports.login = async (req, res) => {
 try {
     const { email, password } = req.body;
     const user=await UserService.findByEmail(email);

     if(!user){
      throw new Error("User doesn't exist!");
     }
     const isMatch=await user.comparePassword(password);

     if(isMatch==false){
            throw new Error("Invalid Password!");
     }

     let tokenData={_id:user._id,email:user.email};

     const token=await UserService.generateToken(tokenData,"secretKey",'1h');

     res.status(200).json({status:true,token:token});


   }
 catch (error) {
  throw error;
  
 }


};