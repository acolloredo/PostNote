import 'dart:math';

import 'package:flutter/material.dart';

class ClassView extends StatelessWidget {
  const ClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Center(
          child: Wrap(
            // physics: const BouncingScrollPhysics(),
            // crossAxisSpacing: 30.0,
            // mainAxisSpacing: 30.0,
            // childAspectRatio: 1.55,
            // crossAxisCount: 5,

            // TODO: use a builder when fetching (to not load everything)
            children: const [
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  const ClassCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 200.0,
        minWidth: 300.0,
        maxHeight: max(MediaQuery.of(context).size.height / 4, 200),
        maxWidth: max(MediaQuery.of(context).size.width / 5, 300),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            color: Colors.white,
            child: Column(children: const [
              Text("Class Number"),
              Text("Professor Name"),
            ]),
          ),
        ),
      ),
    );
  }
}
