import 'package:flutter/material.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          'CSE XXX',
          style: TextStyle(fontSize: 55),
        ),
      ),
      body: Container(
        color: Colors.grey,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Study Groups:',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 1',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 2',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 3',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 4',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 5',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Study Groups:',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 6',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 7',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 8',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 9',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(160, 90),
                      ),
                      child: const Text(
                        'Week 10',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
