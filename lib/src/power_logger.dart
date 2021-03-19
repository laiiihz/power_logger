import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:power_logger/power_logger.dart';
import 'package:power_logger/src/widgets/logger_fab.dart';

class PowerLogger {
  /// debug tag
  static bool debug = true;

  ///初始化
  ///
  ///默认开启debug
  ///
  ///```dart
  ///PowerLogger.init(context,debug:true);
  ///```
  static init(BuildContext context, {bool debug = true}) {
    PowerLogger.debug = debug;
    if (debug)
      Overlay.of(context).insert(OverlayEntry(
        builder: (context) {
          return LoggerFab();
        },
      ));
  }
}
