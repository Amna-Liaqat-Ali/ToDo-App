const router = require('express').Router();
const TodoController = require('../controllers/todo.controller');

router.post('/createToDo',TodoController.createToDo);

module.exports = router;