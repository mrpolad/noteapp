import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  String selectedCategory = "In Progress";

  final Map<String, List<Map<String, String>>> taskCategories = {
    "In Progress": [],
    "Done": [],
  };

  void addTask() {
    final String task = _taskTextController.text;
    final String description = _descriptionTextController.text;

    setState(() {
      taskCategories[selectedCategory]!.add({
        "task": task,
        "description": description,
      });

      _taskTextController.clear();
      _descriptionTextController.clear();
    });
  }

  void clearTask(int index) {
    setState(() {
      taskCategories[selectedCategory]!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentList = taskCategories[selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
            items: ["In Progress", "Done"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _taskTextController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Task',
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionTextController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: addTask,
                  child: Text("Add to $selectedCategory"),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: currentList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(currentList[index]["task"] ?? ""),
                  subtitle: Text(currentList[index]["description"] ?? ""),
                  leading: IconButton(
                    onPressed: () => clearTask(index),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
