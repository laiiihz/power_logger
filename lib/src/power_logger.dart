import 'package:flutter/material.dart';
import 'package:power_logger/src/widgets/logger_fab.dart';

class PowerLogger {
  /// debug tag
  static bool debug = true;

  static OverlayEntry? entry;

  static late BuildContext globalContext;

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
    globalContext = context;
    if (debug) if (debug) _insertToOverlay();
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      PowerLogger.debug = debug;
      globalContext = context;
      if (debug) _insertToOverlay(initAlignment: initAlignment);
    });
  }

  static _insertToOverlay({Alignment initAlignment = Alignment.center}) {
    entry = OverlayEntry(
      builder: (context) {
        return LoggerFab(initAlignment: initAlignment);
      },
    );
    Overlay.of(globalContext)!.insert(entry!);
  }

  static insertToOverlay({Alignment initAlignment = Alignment.center}) =>
      _insertToOverlay(
        initAlignment: initAlignment,
      );

  static removeFromOverlay() {
    if (entry != null) entry!.remove();
  }
}
