import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:power_logger/power_logger.dart';

class PowerLogger {
  static bool debug = true;

  ///初始化
  ///
  ///默认开启debug
  static init(BuildContext context, {bool debug = true}) {
    PowerLogger.debug = debug;
    if (debug)
      Overlay.of(context).insert(OverlayEntry(
        builder: (context) {
          return LoggerFAB();
        },
      ));
  }
}

class LoggerFAB extends StatefulWidget {
  LoggerFAB({Key key}) : super(key: key);

  @override
  _LoggerFABState createState() => _LoggerFABState();
}

class _LoggerFABState extends State<LoggerFAB> {
  double _x = 50;
  double _y = 70;

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  bool _moving = false;

  bool showSubPage = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOutCubic,
      duration: _moving ? Duration.zero : Duration(milliseconds: 300),
      left: _x - 25,
      top: _y - 25,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        opacity: showSubPage ? 0 : 1,
        child: GestureDetector(
          onPanStart: (detail) {
            _moving = true;
          },
          onPanUpdate: (details) {
            setState(() {
              _x = details.globalPosition.dx;
              _y = details.globalPosition.dy;
            });
          },
          onPanEnd: (detail) {
            if ((_x < screenWidth / 2)) {
              _x = 50;
            } else
              _x = screenWidth - 50;
            if (_y > screenHeight - 50) {
              _y = screenHeight - 50;
            } else if (_y < 50) _y = 50;

            _moving = false;
            setState(() {});
          },
          onTap: showSubPage
              ? null
              : () async {
                  showSubPage = true;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PowerLoggerView()),
                  );
                  showSubPage = false;
                },
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 50,
                width: 50,
                child: Icon(
                  Icons.code,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
