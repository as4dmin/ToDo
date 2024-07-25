import 'package:flutter/material.dart';
import 'package:flutter_application_1/todo.dart';

class AppProvider extends ChangeNotifier{

  List<MyTodo> _todos = [];
  List<MyTodo> get todos => _todos;

  addTodo(MyTodo todo){
    _todos.add(todo);
    notifyListeners();
  }

  updateTodo(bool value, int index){
    _todos[index].complete = value;
    notifyListeners();
  }

}