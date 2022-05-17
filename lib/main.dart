import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/screen/addTask.dart';
import 'package:todoapp/screen/editTask.dart';
import 'package:todoapp/screen/viewTask.dart';
import 'package:todoapp/services/taskService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Task> _tasksList = <Task>[];
  final _userService = TaskService();

  getAllTaskDetails() async {
    var tasks = await _userService.readAllTasks();
    _tasksList = <Task>[];
    tasks.forEach((user) {
      setState(() {
        var userModel = Task();
        userModel.id = user['id'];
        userModel.task = user['task'];
        userModel.date = DateTime.parse(user['date'].toString());
        userModel.description = user['description'];
        _tasksList.add(userModel);
      });
    });

    if (tasks.isEmpty) {
      setState(() {
        _tasksList.clear();
      });
    }
  }

  @override
  void initState() {
    getAllTaskDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  _deleteFromDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              "Are Your Sure to Delete?",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  var result = await _userService.deleteTask(userId);
                  if (result != null) {
                    Navigator.pop(context);
                    getAllTaskDetails();
                    _showSuccessSnackBar("Deleted Success");
                  }
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text("Delete"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                ),
                child: const Text("Colse"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tODO"),
      ),
      body: ListView.builder(
          itemCount: _tasksList.length,
          itemBuilder: (context, index) {
            String day = DateTime.parse(_tasksList[index].date.toString()).day.toString();
            String month = DateTime.parse(_tasksList[index].date.toString()).month.toString();
            String year = DateTime.parse(_tasksList[index].date.toString()).year.toString();
            return Card(
              child: ListTile(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewTask(
                                task: _tasksList[index],
                              )));
                }),
                title: Text(_tasksList[index].task ?? ''),
                subtitle: Text("$year.$month.$day"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditTask(
                                        task: _tasksList[index],
                                      ))).then((value) => {
                                if (value != null)
                                  {
                                    getAllTaskDetails(),
                                    _showSuccessSnackBar("User Updated")
                                  }
                              });
                        },
                        icon: const Icon(Icons.edit, color: Colors.teal)),
                    IconButton(
                        onPressed: () {
                          _deleteFromDialog(context, _tasksList[index].id);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddUser()))
              .then((value) => {
                    if (value != null)
                      {getAllTaskDetails(), _showSuccessSnackBar("User Added")}
                  });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
