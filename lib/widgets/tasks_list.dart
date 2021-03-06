import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoey_app_flutter/widgets/task_tile.dart';
import 'package:todoey_app_flutter/models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TaskData>(context, listen: false).fetchAndSetPlace(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent[100]),
              ),
            )
          : Consumer<TaskData>(
              builder: (context, taskData, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final task = taskData.tasks[index];
                    return TaskTile(
                      taskTitle: task.name,
                      isChecked: task.isDone,
                      checkboxCallback: (bool checkboxState) {
                        taskData.updateTask(task);
                      },
                      longpressCallback: () {
                        taskData.deleteTask(task);
                      },
                    );
                  },
                  itemCount: taskData.taskCount,
                );
              },
            ),
    );
  }
}
