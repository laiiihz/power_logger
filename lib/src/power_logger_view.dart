import 'package:flutter/material.dart';
import 'package:power_logger/power_logger.dart';
import 'package:power_logger/src/views/info_view.dart';
import 'package:power_logger/src/views/logger_view.dart';
import 'package:power_logger/src/views/settings_view.dart';

///Logger view
class PowerLoggerView extends StatefulWidget {
  PowerLoggerView({Key key}) : super(key: key);

  @override
  _PowerLoggerViewState createState() => _PowerLoggerViewState();
}

class _PowerLoggerViewState extends State<PowerLoggerView> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  void Function(void Function()) _setState;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Logger View'),
          actions: [
            IconButton(
              icon: Icon(Icons.clear_all_rounded),
              onPressed: () {
                LoggerData.clear();
                setState(() {});
              },
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _currentIndex = index;
            if (_setState != null) _setState(() {});
          },
          children: [
            LoggerView(),
            InfoView(),
            SettingsView(),
          ],
        ),
        bottomNavigationBar: StatefulBuilder(
          builder: (context, kSetState) {
            _setState = kSetState;
            return BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: Colors.white,
              onTap: (index) {
                _currentIndex = index;
                kSetState(() {});
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                );
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.assessment), label: '日志'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.perm_device_information), label: '信息'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: '设置'),
              ],
            );
          },
        ),
      ),
    );
  }
}
