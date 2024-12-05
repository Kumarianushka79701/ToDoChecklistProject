import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/modules/todochecklistPage/provider/todo_provider.dart';
import 'package:todoapp/utils/colors.dart';
import 'package:todoapp/widgets/button.dart';
import 'package:todoapp/widgets/common_appbar.dart';
import 'package:todoapp/widgets/text_widget.dart';

class ToDoListPage extends StatelessWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final taskController = TextEditingController();

    return Scaffold(
      appBar:
          getAppBar(context, title: getTodoListAppBarTitle(context), onTap: () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                 Button(
                  width: width * 0.2,
                  label: "Add",
                  onTap: () {
                    todoProvider.addTask(taskController.text);
                    taskController.clear();
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, provider, child) {
                  return provider.tasks.isEmpty
                      ? const Center(child: Text('No tasks yet. Add one!'))
                      : ListView.builder(
                          itemCount: provider.tasks.length,
                          itemBuilder: (context, index) {
                            final task = provider.tasks[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                title: Text(
                                  task['title'],
                                  style: TextStyle(
                                    decoration: task['isComplete']
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                leading: Checkbox(
                                  value: task['isComplete'],
                                  onChanged: (_) =>
                                      provider.toggleTaskCompletion(index),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      task['isComplete']
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: task['isComplete']
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          provider.deleteTask(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget getTodoListAppBarTitle(BuildContext context) {
  return const TextWidget(
    label: "To Do List",
    textColor: ToDoColor.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}