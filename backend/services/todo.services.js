const todoModel = require('../model/todo.model');
const ToDoModel = require('../model/todo.model');

class ToDoService {
    static async createToDo({ userId, title, desc }) {
        //creating todo list
        const createToDo = new ToDoModel({ userId, title, desc });
            return await createToDo.save();
    }

     static async getToDoList({ userId}) {
        //getting all todo list of particular user through his ID
        const getToDoList = await todoModel.find({ userId });
            return getToDoList;
    }

     static async deleteToDo({ id}) {
        //delete item from its id
        const deletedItem = await todoModel.findOneAndDelete({_id:id});
            return deletedItem;
    }



}

module.exports = ToDoService;