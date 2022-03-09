import 'package:flutter/material.dart';
import 'package:equation_recognizer/constant.dart';
import 'package:equation_recognizer/draw_painter.dart';

class RecognizerScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RecognizerScreen({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _RecognizerScreen createState() => _RecognizerScreen();
}

class _RecognizerScreen extends State<RecognizerScreen> {
  List<Offset> points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('tori kam garney '),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                alignment: Alignment.center,
                child: Text('Header'),
              ),
            ),
            Container(
              decoration: new BoxDecoration(
                border: new Border.all(
                  width: 3.0,
                  color: Colors.blue,
                ),
              ),
              child: Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        RenderBox renderBox =
                            context.findRenderObject() as RenderBox;
                        points.add(
                            renderBox.globalToLocal(details.globalPosition));
                      });
                    },
                    onPanStart: (details) {
                      setState(() {
                        RenderBox renderBox =
                            context.findRenderObject() as RenderBox;
                        points.add(
                            renderBox.globalToLocal(details.globalPosition));
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        points.add(Offset.zero);
                      });
                    },
                    child: ClipRect(
                      child: CustomPaint(
                        size: Size(kCanvasSize, kCanvasSize),
                        painter: drawingPainter(
                          offsetPoints: points,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text('Footer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
