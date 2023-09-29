import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
          actions: const [
            Icon(Icons.delete),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final List<String> todoList = []; // List to store todo items
  final TextEditingController _textEditingController = TextEditingController();

  void addTodo() {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        todoList.add(_textEditingController.text);
        _textEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: 'Enter your task',
              suffixIcon: IconButton(
                onPressed: addTodo,
                icon: const FaIcon(FontAwesomeIcons.plus),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(todoList[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
