const router = require('express').Router();
const userController = require('../controllers/user.controller');

//hit apis
router.post('/register', userController.register);

module.exports = router;