import 'package:flutter/material.dart';

import './exports.dart';

// ff607d8b
Color colorLuminance(String hex, {lum = 0.3}) {
  for (int i = 1; i <= 3; i++) {
    int start = i * 2;
    int? end = start + 2 == 8 ? null : start + 2;
    String sub = hex.substring(start, end);
    int _int = int.parse(sub, radix: 16);
    String _str = min(max(0, _int + _int * lum), 255).round().toRadixString(16);
    hex = hex.replaceRange(start, end, _str);
  }

  return Color(int.parse('0x$hex'));
}

Color getAdjustColor(Color baseColor, int amount) {
  Map colors = {
    "red": baseColor.red,
    "green": baseColor.green,
    "blue": baseColor.blue
  };
  colors = colors.map((key, value) {
    if (value + amount < 0) return MapEntry(key, 0);
    if (value + amount > 255) return MapEntry(key, 255);
    return MapEntry(key, value + amount);
  });
  return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
}

List<Color> getFlatGradients(baseColor, depth) {
  return [
    baseColor,
    baseColor,
  ];
}

List<Color> getConcaveGradients(baseColor, depth) {
  return [
    getAdjustColor(baseColor, -depth),
    getAdjustColor(baseColor, depth),
  ];
}

List<Color> getConvexGradients(baseColor, depth) {
  return [
    getAdjustColor(baseColor, depth),
    getAdjustColor(baseColor, -depth),
  ];
}
