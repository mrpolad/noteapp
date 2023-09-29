import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final List<String> taskList = [];

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    taskList.clear();
                  });
                },
                icon: const Icon(Icons.delete)),
            const SizedBox(
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
  final TextEditingController _textEditController = TextEditingController();
  int index = 0;
  void addTask() {
    setState(() {
      taskList.add(_textEditController.text);
      _textEditController.clear();
    });
  }

  void clearTask() {
    setState(() {
      taskList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: TextFormField(
            controller: _textEditController,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: 'Add Task',
              suffixIcon: IconButton(
                onPressed: addTask,
                icon: const FaIcon(FontAwesomeIcons.plus),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(taskList[index]),
                leading: IconButton(
                    onPressed: clearTask, icon: const Icon(Icons.delete)),
              );
            },
          ),
        ),
      ],
    );
  }
}
