import 'dart:ui';
export 'dart:math';
export 'dart:typed_data';
export 'dart:convert';

export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter/rendering.dart';
export 'package:flutter_highlight/flutter_highlight.dart';
export 'package:flutter_highlight/themes/github.dart';
export 'package:flutter_highlight/themes/atom-one-dark.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:screenshot/screenshot.dart';
export 'package:url_launcher/url_launcher.dart';

export './app.dart';
export './utils.dart';
export './routes.dart';
export './home/home_page.dart';
export './state/app_state.dart';
export './state/app_state_provider.dart';

const String githubRepoUrl = 'https://github.com/xrr2016/neumorphism';
const String buymeCoffeeUrl =
    'https://www.buymeacoffee.com/coldstone/hi-made-app-generate-flutter-code';

// https://dribbble.com/search/Glassmorphism
// https://dribbble.com/tags/neumorphism

final List<Color> colors = [
  const Color(0xff333333),
  const Color(0xff4caf50),
  const Color(0xff9c27b0),
  const Color(0xff5758BB),
  const Color(0xff955539),
  const Color(0xff6F1E51),
  const Color(0xffED4C67),
  const Color(0xffC4E538),
  const Color(0xff9980FA),
  const Color(0xffE96831),
  const Color(0xff48c0a3),
  const Color(0xffD1667C),
  const Color(0xff71A89C),
  const Color(0xff296A73),
  const Color(0xffa69abd),
  const Color(0xffe198b4),
  const Color(0xffcd5e3c),
  const Color(0xff89c3eb),
  const Color(0xff0eb83a),
  const Color(0xff392f41),
  const Color(0xff21a675),
  const Color(0xff83ccd2),
];
