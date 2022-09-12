import 'dart:ui';

import 'package:flutter/material.dart';

class HomeItems extends StatelessWidget {
  const HomeItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          color: Colors.teal[600],
          alignment: Alignment.center,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () => print('quiz'),
            child: const Text('Quiz'),
          ),
        ),
        Container(
          color: Colors.teal[600],
          alignment: Alignment.center,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () => print('Expense planner'),
            child: const Text('Expense planner'),
          ),
        ),
      ],
    );
  }
}
