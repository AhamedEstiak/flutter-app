import 'package:flutter/material.dart';

import './widgets/homeItems.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Choose app'),
          backgroundColor: Colors.blueGrey,
        ),
        body: const HomeItems(),
      ),
    );
  }
}
