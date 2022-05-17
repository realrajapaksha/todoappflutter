import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';

class ViewTask extends StatefulWidget {
  final Task task;
  const ViewTask({Key? key, required this.task}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    String day = DateTime.parse(widget.task.date.toString()).day.toString();
    String month = DateTime.parse(widget.task.date.toString()).month.toString();
    String year = DateTime.parse(widget.task.date.toString()).year.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Task"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const Text(
            "Full Details",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Task Name",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(widget.task.task ?? '',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Created Date",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
          Text("$year.$month.$day",
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(widget.task.description ?? '',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}
