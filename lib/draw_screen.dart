import 'package:flutter/material.dart';
import 'package:equation_recognizer/constant.dart';
import 'package:equation_recognizer/draw_painter.dart';
//import 'package:equation_recognizer/pic.dart';
import 'package:equation_recognizer/request.dart';

class RecognizerScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RecognizerScreen({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _RecognizerScreen createState() => _RecognizerScreen();
}

class _RecognizerScreen extends State<RecognizerScreen> {
  var _index = 0;
  void _random() {
    setState(() {
      _index = _index + 1;
      _index %= 2;
    });
  }

  List<Offset> points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    var _question = ['', 'who is yaman?', 'why is yaman hero'];
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
            Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              color: Colors.white,
              width: 200.0,
              height: 100.0,
              child: ElevatedButton(
                onPressed: HttpService.login(points.),
                child: Text('submit'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(_question[_index]),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                decoration: new BoxDecoration(
                  border: new Border.all(
                    width: 3.0,
                    color: Colors.orange,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => points.clear());
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
