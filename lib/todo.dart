import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final _todos = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Todo App")),
        body: _buildTodos(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddTodo(
                      callback: (String value) => setState(() {
                            _todos.add(value);
                          }));
                });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ));
  }

  Widget _buildTodos() {
    final tiles = _todos.asMap().entries.map((entry) {
      final i = entry.key;
      final todo = entry.value;
      return ListTile(
          title: Text(
            todo,
            style: _biggerFont,
          ),
          trailing: InkWell(
              child: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 28,
              ),
              splashColor: Colors.black,
              onTap: () {
                setState(() {
                  _todos.removeAt(i);
                });
              }));
    });
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(tiles: tiles, context: context).toList()
        : <Widget>[];
    return ListView(children: divided);
  }
}

class AddTodo extends StatefulWidget {
  final void Function(String text) callback;

  const AddTodo({Key? key, required this.callback}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Todo"),
      content: TextField(
        autofocus: true,
        onChanged: (value) => setState(() {
          _text = value;
        }),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              print(_text);
              widget.callback(_text);
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'))
      ],
    );
  }
}
