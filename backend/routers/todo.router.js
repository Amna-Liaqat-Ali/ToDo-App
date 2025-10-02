const router = require('express').Router();
const TodoController = require('../controllers/todo.controller');

router.post('/createToDo',TodoController.createToDo);
router.get('/getToDoList',TodoController.getToDoList);

module.exports = router;