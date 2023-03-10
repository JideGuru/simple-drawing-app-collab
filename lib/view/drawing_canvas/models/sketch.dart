import 'package:flutter/material.dart';

class Sketch {
  final List<Offset> points;
  final Color color;
  final double size;
  final SketchType type;

  Sketch({
    required this.points,
    this.color = Colors.black,
    this.size = 10,
    this.type = SketchType.scribble,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> pointsMap =
        points.map((offset) => {'dx': offset.dx, 'dy': offset.dy}).toList();
    return {
      'points': pointsMap,
      'color': color.toHex(),
      'size': size,
      'type': type.toRegularString(),
    };
  }

  factory Sketch.fromJson(Map<String, dynamic> json) {
    List<Offset> points =
        (json['points'] as List).map((e) => Offset(double.parse(e['dx'].toString()), double.parse(e['dy'].toString()))).toList();
    return Sketch(
      points: points,
      color: (json['color'] as String).toColor(),
      size: double.parse(json['size'].toString()),
      type: (json['type'] as String).toSketchTypeEnum(),
    );
  }
}

enum SketchType { scribble, line, rectangle, circle }

extension SketchTypeX on SketchType {
  toRegularString() => toString().split('.')[1];
}

extension SketchTypeExtension on String {
  toSketchTypeEnum() =>
      SketchType.values.firstWhere((e) => e.toString() == 'SketchType.$this');
}

extension ColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    } else {
      return Colors.black;
    }
  }
}

extension ColorExtensionX on Color {
  String toHex() => '#${value.toRadixString(16).substring(2, 8)}';
}
