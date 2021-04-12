import 'package:flutter/material.dart';
import 'package:power_logger/src/data/logger_data.dart';
import 'package:power_logger/src/parser/data_parser.dart';

class LoggerView extends StatefulWidget {
  LoggerView({Key? key}) : super(key: key);

  @override
  _LoggerViewState createState() => _LoggerViewState();
}

class _LoggerViewState extends State<LoggerView> {
  updateList() => setState(() {});

  @override
  void initState() {
    super.initState();
    LoggerData.addListener(updateList);
  }

  @override
  void dispose() {
    LoggerData.removeListener(updateList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return LoggerDataParser.builder(LoggerData.data[index]);
      },
      itemCount: LoggerData.data.length,
    );
  }
}
