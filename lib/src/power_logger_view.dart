import 'package:flutter/material.dart';
import 'package:power_logger/power_logger.dart';

class PowerLoggerView extends StatefulWidget {
  PowerLoggerView({Key key}) : super(key: key);

  @override
  _PowerLoggerViewState createState() => _PowerLoggerViewState();
}

class _PowerLoggerViewState extends State<PowerLoggerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logger View'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return LoggerDataParser.builder(LoggerData.data[index]);
        },
        itemCount: LoggerData.data.length,
      ),
    );
  }
}