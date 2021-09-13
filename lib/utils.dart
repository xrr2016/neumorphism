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
