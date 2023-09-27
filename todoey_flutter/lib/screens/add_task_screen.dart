import 'package:flutter/material.dart';
import 'package:todoey_flutter/constants.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                enabledBorder: kUnderlineInputTextfield,
                focusedBorder: kUnderlineInputTextfield,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(
              height: 35.0,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 70.0,
                minWidth: double.infinity,
              ),
              child: TextButton(
                onPressed: () {
                  var newTask = controller.text.toString();
                  if (newTask.isNotEmpty) {
                    var taskData = context.read<TaskData>();
                    taskData.addTask(newTask);
                  }
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.lightBlueAccent),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
