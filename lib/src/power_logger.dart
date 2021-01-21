import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:power_logger/power_logger.dart';

class PowerLogger {
  static init(BuildContext context) {
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
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOutCubic,
      duration: _moving ? Duration.zero : Duration(milliseconds: 300),
      left: _x - 25,
      top: _y - 25,
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
          if ((_y < screenHeight / 2)) {
            _y = 70;
          } else
            _y = screenHeight - 50;
          _moving = false;
          setState(() {});
        },
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PowerLoggerView()),
        ),
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
    );
  }
}