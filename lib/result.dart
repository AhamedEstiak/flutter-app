import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetHandler;

  const Result(this.totalScore, this.resetHandler);

  String? get resultPhrase {
    String? resultText;

    if (totalScore <= 8) {
      resultText = 'You are awesome!';
    } else if (totalScore <= 12) {
      resultText = 'You are well!';
    } else if (totalScore <= 16) {
      resultText = 'You are strange!';
    } else {
      resultText = 'You are bad!';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase as String,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetHandler,
            child: Text('Reset quiz'),
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
