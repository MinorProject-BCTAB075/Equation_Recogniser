import 'dart:ui';

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:equation_recognizer/constant.dart';
import 'package:equation_recognizer/draw_painter.dart';
import 'package:equation_recognizer/request.dart';

class RecognizerScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RecognizerScreen({required Key key, required this.title}) : super(key: key);
  final String title;
  @override
  _RecognizerScreen createState() => _RecognizerScreen();
}
double kCanvasSize=200;

 Future processCanvasPoints(List<Offset> points) async {

  // We create an empty canvas 280x280 pixels
  final canvasSizeWithPadding = kCanvasSize + (2 * 40);
  final canvasOffset = Offset(40, 40);
  final recorder = PictureRecorder();
  final canvas = Canvas(
    recorder,
    Rect.fromPoints(
      Offset(0.0, 0.0),
      Offset(canvasSizeWithPadding, canvasSizeWithPadding),
    ),
  );

  // Our image is expected to have a black background and a white drawing trace,
  // quite the opposite of the visual representation of our canvas on the screen
  canvas.drawRect(
      Rect.fromLTWH(0, 0, canvasSizeWithPadding, canvasSizeWithPadding),
      wBackground
  );

  // Now we draw our list of points on white paint
  for (int i = 0; i < points.length - 1; i++) {
    if (points[i] != null && points[i + 1] != null) {
      canvas.drawLine(
          points[i] + canvasOffset, points[i + 1] + canvasOffset, drawingPaint);
    }
  }

  // At this point our virtual canvas is ready and we can export an image from it
  final picture = recorder.endRecording();
  final img = await picture.toImage(
    canvasSizeWithPadding.toInt(),
    canvasSizeWithPadding.toInt(),
  );
  final imgBytes = await img.toByteData(format: ImageByteFormat.png);
  return imgBytes!.buffer.asUint8List();
  // return pngUint8List;
}

class _RecognizerScreen extends State<RecognizerScreen> {
  var _index = 0;
  var _output = "RESULT";
  void _random() {
    setState(() {
      _index = _index + 1;
      _index %= 2;
    });
  }
  void setNewParameter() async {
    var output =await HttpService.predict(await processCanvasPoints(points));
    setState(() {
    _output = output;
    });
  }

  List<Offset> points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    kCanvasSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Handwriting Equation Recognizer'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Colors.white
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
                child: Text(
                  _output,
                  style: const TextStyle(
                      fontSize: 40                      ,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54
                  ),
                ),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height/4,
                width: kCanvasSize,
                decoration: BoxDecoration(
                  color: Colors.black12
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              color: Colors.white,
              width: kCanvasSize,
              height: MediaQuery.of(context).size.height*0.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: setNewParameter,
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(kCanvasSize/2.3,kCanvasSize/5)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => points.clear());
                    },
                    child: Icon(
                      Icons.delete,
                      size: kCanvasSize/8,
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(kCanvasSize/2.3,kCanvasSize/5)),
                    ),
                  ),
                ],
              )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/14,
            )
          ],
        ),
      ),
    );
  }
}
