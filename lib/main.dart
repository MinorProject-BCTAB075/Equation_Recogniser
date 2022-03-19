
import 'package:flutter/material.dart';
import 'package:equation_recognizer/draw_screen.dart';

void main() => runApp(handwritten());

class handwritten extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RecognizerScreen(
          key: const Key("equation"),
          title: 'equation',
        )
    );
  }
}
