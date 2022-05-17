import 'package:todoapp/db_helper/repository.dart';

import '../model/task.dart';

class TaskService{
  late Repository _repository;
  TaskService(){
    _repository = Repository();
  }

  //save task
  saveTask(Task task) async{
    return await _repository.insertData("tasks", task.taskMap());
  }

  //read all tasks
  readAllTasks() async {
    return await _repository.readtData('tasks');
  }

  //edit task 
  updateTask(Task task) async{
    return await _repository.updateData("tasks", task.taskMap()) ;
  }

  deleteTask(taskId) async{
    return await _repository.deleteDataById("tasks", taskId);
  }
}