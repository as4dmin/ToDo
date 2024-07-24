import 'package:flutter/material.dart';

class TODO extends StatefulWidget {
  const TODO({super.key});


  @override
  State<TODO> createState() => _TODOState();
}

class _TODOState extends State<TODO> {
  Priority priority=Priority.low;
  final namecontroller = TextEditingController();
  final _controller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         addTodo();          
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: MyTodo.todos.isEmpty? 
      Center(child:  Text("Nothing to do")) : 
      ListView.builder(
        itemCount: MyTodo.todos.length,
        itemBuilder: (context,index){
          final todo = MyTodo.todos[index];
          return TodoItem(
            todo: todo, 
            onChanged: (value){
              setState(() {
                MyTodo.todos[index].complete = value;
              });
            });
        })
    );
  }

  void addTodo() {
     showModalBottomSheet(
        context: context,
        isScrollControlled: true,
         builder: (BuildContext context)=> StatefulBuilder(
           builder:(context, setBuilderState) => Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      label: Text("What to do?"),
                      icon: Icon(Icons.file_present)
                    ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("SELECT PRIORITY"),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       children: [
                         Radio<Priority>(
                          value: Priority.low,
                          groupValue: priority,
                           onChanged: (value){
                            setBuilderState(() {
                              priority=value!;
                            });
                           }
                           ),
                           Text(Priority.low.name),
                           Radio<Priority>(
                          value: Priority.normal,
                          groupValue: priority,
                           onChanged: (value){
                            setBuilderState(() {
                              priority=value!;
                            });
                           }
                           ),
                           Text(Priority.normal.name),
                           Radio<Priority>(
                          value: Priority.high,
                          groupValue: priority,
                           onChanged: (value){
                            setBuilderState(() {
                              priority=value!;
                            });
                           }
                           ),
                           Text(Priority.high.name),
                       ],
                     ),
                   ),
                   ElevatedButton(
                    onPressed: _save,
                     child: Text("SAVE"),
                   ),
               ],
             ),
           ),
         ),
         );
  }

  void _save(){
    if(_controller.text.isEmpty){
      showMsg(context,'Input field must not be empty');
      return;
    }

    final todo= MyTodo(
      id: DateTime.now().millisecondsSinceEpoch,
      name: _controller.text,
      priority: priority,
    );

    MyTodo.todos.add(todo);
    _controller.clear();
    setState(() {
      Navigator.pop(context);
    });

  }

  void showMsg(BuildContext context,String s){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Caution!"),
      content: Text(s),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
         child: Text("Close"))
      ],
    ));
    
  } 
}

class TodoItem extends StatelessWidget {
  final MyTodo todo;
  final Function(bool) onChanged;

  const TodoItem({super.key,required this.todo,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(todo.name),
      subtitle: Text("Priority: ${todo.priority.name}"),
      value: todo.complete,
     onChanged: (value){
        onChanged(value!);
     });
  }
}

class MyTodo{
  int id;
  String name;
  bool complete;
  Priority priority;
  MyTodo({
    required this.id,
    required this.name,
    this.complete = false,
    required this.priority,}
  );

  static List<MyTodo> todos =[];


}

enum Priority{
  low, normal,high
}
