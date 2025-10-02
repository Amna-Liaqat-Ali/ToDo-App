const ToDoService = require('../services/todo.services');

exports.createToDo = async (req, res, next) => {
    try {
        const { userId, title, desc } = req.body;
        const todo = await ToDoService.createToDo({userId, title, desc});

        res.json({status:true,success:todo});



    } catch (error) {
        throw error;
    }

}
