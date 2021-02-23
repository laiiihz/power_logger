import 'package:flutter/material.dart';
import 'package:power_logger/src/data/logger_data.dart';
import 'package:power_logger/src/parser/data_parser.dart';

class LoggerView extends StatefulWidget {
  LoggerView({Key key}) : super(key: key);

  @override
  _LoggerViewState createState() => _LoggerViewState();
}

class _LoggerViewState extends State<LoggerView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(5),
      separatorBuilder: (_, __) => SizedBox(height: 5),
      itemBuilder: (context, index) {
        return LoggerDataParser.builder(LoggerData.data[index]);
      },
      itemCount: LoggerData.data.length,
    );
  }
}
