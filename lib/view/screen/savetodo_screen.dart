import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:placement_task/controller/todo_controller.dart';

class saveTodoScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  saveTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = todoController.isDarkTheme.value;
    return Obx( () =>
      Scaffold(
        backgroundColor: isDarkTheme ? Colors.black38 : Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color:
                  todoController.isDarkTheme.value ? Colors.white : Colors.white,
            ),
          ),
          title: Text(
            'Saved Todos',
            style: TextStyle(
              color:
                  todoController.isDarkTheme.value ? Colors.white : Colors.white,
            ),
          ),
          backgroundColor:
              todoController.isDarkTheme.value ? Colors.black : Color(0xff1E3E62),
        ),
        body: Obx(
          () {
            final savetodo = todoController.savetodo;
            return savetodo.isEmpty
                ? Center(
                    child: Text(
                    'No saved todos',
                    style: TextStyle(
                      color: todoController.isDarkTheme.value
                          ? Colors.white
                          : Colors.black, // Theme-based text color
                    ),
                  ))
                : ListView.builder(
                    itemCount: savetodo.length,
                    itemBuilder: (context, index) {
                      final todo = savetodo[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          color: todoController.isDarkTheme.value
                              ? Colors.grey[850]
                              : Colors.white,
                          child: ListTile(
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                color: todoController.isDarkTheme.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  todo.completed ? 'Completed' : 'Pending',
                                  style: TextStyle(
                                    color: todo.completed
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                Icon(
                                  todo.completed
                                      ? Icons.check_circle
                                      : Icons.error,
                                  color:
                                      todo.completed ? Colors.green : Colors.red,
                                  size: 13,
                                )
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  todoController.toggleBookmark(todo);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: todoController.isDarkTheme.value
                                      ? Colors.white
                                      : Colors.red,
                                )),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
