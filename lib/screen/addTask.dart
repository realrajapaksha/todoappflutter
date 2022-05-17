import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/services/taskService.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var _taskNameController = TextEditingController();
  var _taskDesController = TextEditingController();

  bool _validateTaskName = false;
  bool _validateTaskDes = false;

  var _taskServices = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Task")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New Task",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _taskNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Task",
                  labelText: "Task Name",
                  errorText: _validateTaskName ? "can't be empty" : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _taskDesController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Task Description",
                  labelText: "Task Description",
                  errorText: _validateTaskDes ? "can't be empty" : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _taskNameController.text.isEmpty
                              ? _validateTaskName = true
                              : _validateTaskName = false;
                          _taskDesController.text.isEmpty
                              ? _validateTaskDes = true
                              : _validateTaskDes = false;
                        });
                        if (_validateTaskName == false && _validateTaskDes == false) {
                          //save data sqflite
                          var _task = Task();
                          _task.task = _taskNameController.text;
                          _task.date = DateTime.now();
                          _task.description = _taskDesController.text;
                          var result = await _taskServices.saveTask(_task);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text("Save")),
                  const SizedBox(
                    width: 20.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _taskNameController.text = "";
                        _taskDesController.text = "";
                      },
                      child: const Text("Clear")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
