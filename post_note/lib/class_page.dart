import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildWeekButton(int week) {
      return ElevatedButton(
        onPressed: () {
          // Add button action
        },
        style: ElevatedButton.styleFrom(
            //backgroundColor: Colors.green,
            ),
        child: Text(
          'Week $week',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    }

    List<Widget> generateWeekButtons() {
      List<Widget> buttons = [];
      for (int week = 1; week <= 10; week++) {
        buttons.add(buildWeekButton(week));
      }
      return buttons;
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          'CSE XXX',
          style: TextStyle(fontSize: 55),
        ),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Palette.fernGreen,
                    child: const Center(
                      child: Text(
                        'Study Groups:',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Add space here
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: Palette.fernGreen,
                    child: const Align(
                      alignment: Alignment(-0.85, -0.7),
                      child: Text(
                        'Currently in:',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Add space here
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Palette.fernGreen,
                    child: const Align(
                      alignment: Alignment(-0.75, -0.7),
                      child: Text(
                        'Request to join others:',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Palette.fernGreen,
                      child: const Center(
                        child: Text(
                          'Week Folders for Notes:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // Add space here
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: generateWeekButtons(),
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
