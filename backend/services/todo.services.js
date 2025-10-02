const ToDoModel = require('../model/todo.model');

class ToDoService {
    static async createToDo({ userId, title, desc }) {
        //creating todo list
        const createToDo = new ToDoModel({ userId, title, desc });
            return await createToDo.save();
    }
}

module.exports = ToDoService;