import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _tasks = []; // Only task names, no dates

  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    final task = _taskController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(task);
      });
      _taskController.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 26, 51),
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 2, 26, 51),
      body: SafeArea(
        child: Column(
          children: [
            // Input field + Add button
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        hintText: 'Enter new task',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addTask,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),

            // Task List
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "No tasks yet!",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: ListTile(
                            title: Text(
                              _tasks[index],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(index),
                            ),
                          ),
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
