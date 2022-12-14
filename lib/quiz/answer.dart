import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  const Answer(
    this.selectHandler,
    this.answerText,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}
