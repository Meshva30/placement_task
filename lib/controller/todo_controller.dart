import 'dart:convert';

import 'package:get/get.dart';
import 'package:placement_task/model/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/todo_helper.dart';

class TodoController extends GetxController {
  var apiHelper = ApiHelper();
  List<TodoModel> todos = [];
  RxList<TodoModel> savetodo = <TodoModel>[].obs;
  RxBool isGridView = true.obs;
  RxBool isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    // loadSavedTodos();
  }

  Future<List<TodoModel>> fetchApi() async {
    final data = await apiHelper.fetchData();
    todos = data.map((json) => TodoModel.fromJson(json)).toList();
    return todos;
  }

  void toggleGridView() {
    isGridView.value = !isGridView.value;
  }

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
  }

  Future<void> saveTodo(TodoModel todo) async {
    final data = await SharedPreferences.getInstance();
    if (!savetodo.any((item) => item.id == todo.id)) {
      savetodo.add(todo);
    }
    final saveList = savetodo.map((e) => jsonEncode(e.toJson())).toList();
    await data.setStringList('savedTodos', saveList);
  }

  Future<void> loadsavetodo() async {
    final data = await SharedPreferences.getInstance();
    final saveList = data.getStringList('savedTodo') ?? [];
    savetodo.value =
        saveList.map((e) => TodoModel.fromJson(json.decode(e))).toList();
  }

  Future<void> toggleBookmark(TodoModel todo) async {
    final data = await SharedPreferences.getInstance();
    if (savetodo.any((item) => item.id == todo.id)) {
      savetodo.removeWhere((item) => item.id == todo.id);
    } else {
      savetodo.add(todo);
    }
    final saveList = savetodo.map((e) => json.encode(e.toJson())).toList();
    await data.setStringList('savedTodos', saveList);
  }

  Future<void> removeTodo(TodoModel todo) async {
    final data = await SharedPreferences.getInstance();
    savetodo.removeWhere((item) => item.id == todo.id);
    final saveList = savetodo.map((e) => json.encode(e.toJson())).toList();
    await data.setStringList('savedTodos', saveList);
  }
}
