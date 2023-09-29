import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
