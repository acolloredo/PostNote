import 'package:flutter/material.dart';

class ClassView extends StatelessWidget {
  const ClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 30.0,
        childAspectRatio: 1.55,
        crossAxisCount: 5,
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
          ClassCard(),
          ClassCard(),
          ClassCard(),
          ClassCard(),
          ClassCard(),
        ],
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
    return const SizedBox(
      // height: double.maxFinite,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Card(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
