import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  static start(
    BuildContext context, {
    bool debug = true,
    Alignment initAlignment = Alignment.center,
  }) {
    PowerLogger.debug = debug;
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (debug) _insertToOverlay(context, initAlignment: initAlignment);
    });
  }

  static _insertToOverlay(
    BuildContext context, {
    Alignment initAlignment = Alignment.center,
  }) {
    Overlay.of(context)!.insert(OverlayEntry(
      builder: (context) {
        return LoggerFab(initAlignment: initAlignment);
      },
    ));
  }
}
