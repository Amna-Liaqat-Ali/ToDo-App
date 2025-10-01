const UserService = require('../services/user.services');

// Handles request/response from frontend
exports.register = async (req, res) => {
  try {
       console.log("Request Body:", req.body);
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