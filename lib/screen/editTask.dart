import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';
import '../services/taskService.dart';

class EditTask extends StatefulWidget {
  final Task task;

  const EditTask({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var _taskNameController = TextEditingController();
  var _taskDesontroller = TextEditingController();

  bool _validateTaskName = false;
  bool _validateTaskDes = false;

  var _taskServices = TaskService();

  @override
  void initState() {
    setState(() {
      _taskNameController.text = widget.task.task ?? '';
      _taskDesontroller.text = widget.task.description ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Task")),
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
                  hintText: "Enter Task Name",
                  labelText: "Task Name",
                  errorText: _validateTaskName ? "can't be empty" : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _taskDesontroller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Description",
                  labelText: "Description",
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
                          _taskDesontroller.text.isEmpty
                              ? _validateTaskDes = true
                              : _validateTaskDes = false;
                        });

                        if (_validateTaskName == false &&
                            _validateTaskDes == false) {
                          //save data sqflite
                          var _task = Task();
                          _task.id = widget.task.id;
                          _task.task = _taskNameController.text;
                          _task.description = _taskDesontroller.text;
                          _task.date = widget.task.date;
                          var result = await _taskServices.updateTask(_task);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text("Update Task")),
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
                        _taskDesontroller.text = "";
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
