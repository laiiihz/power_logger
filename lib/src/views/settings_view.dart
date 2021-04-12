import 'package:flutter/material.dart';
import 'package:power_logger/power_logger.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: Text('终端日志'),
          subtitle: Text(''),
          value: LoggerData.markLogger,
          onChanged: (state) {
            LoggerData.setLogger(state);
            setState(() {});
          },
        ),
      ],
    );
  }
}
