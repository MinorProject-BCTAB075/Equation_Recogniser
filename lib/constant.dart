import 'dart:ui';
import 'package:flutter/material.dart';

const double kStrokeWidth = 4.0;
const Color kBlackBrushColor = Colors.black;
const Color kWhiteBrushColor = Colors.white;
const bool kIsAntiAlias = true;
final Paint wBackground = Paint()
  ..strokeCap = StrokeCap.square
  ..isAntiAlias = kIsAntiAlias
  ..color = kWhiteBrushColor
  ..strokeWidth = kStrokeWidth;
final Paint drawingPaint = Paint()
  ..strokeCap = StrokeCap.square
  ..isAntiAlias = kIsAntiAlias
  ..color = kBlackBrushColor
  ..strokeWidth = kStrokeWidth;