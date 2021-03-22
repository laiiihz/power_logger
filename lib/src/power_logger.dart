import 'dart:ui';

import 'package:flutter/material.dart';
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
  @Deprecated("use PowerLogger.start")
  static init(BuildContext context, {bool debug = true}) {
    PowerLogger.debug = debug;
    if (debug) if (debug) _insertToOverlay(context);
  }

  ///初始化
  ///
  ///默认开启debug
  ///
  ///```dart
  ///PowerLogger.start(context,debug:true);
  ///```
  static start(BuildContext context, {bool debug = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PowerLogger.debug = debug;
      if (debug) _insertToOverlay(context);
    });
  }

  static _insertToOverlay(BuildContext context) {
    Overlay.of(context).insert(OverlayEntry(
      builder: (context) {
        return LoggerFab();
      },
    ));
  }
}
