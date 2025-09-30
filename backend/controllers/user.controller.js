const UserService = require('../services/user.services');

// Handles request/response from frontend
exports.register = async (req, res) => {
  try {
    const { email, password } = req.body;

    // check if user already exists
    const existingUser = await UserService.findByEmail(email);
    if (existingUser) {
      return res.status(400).json({ error: "User already exists!" });
    }

    const user = await UserService.registerUser({ email, password });
    return res.status(201).json({
      message: "User registered successfully!",
      data: user
    });

  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};