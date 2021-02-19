import 'package:power_logger/power_logger.dart';

/// logger data storage
class LoggerData {
  static int _maxLength = 100;

  static List<dynamic> _data = [];

  /// the real logger data.
  static List<dynamic> get data => _data;

  /// set the logger max number.
  static setMax(int max) {
    _maxLength = max ?? 100;
  }

  /// add data to logger
  static addData(dynamic data) {
    if (PowerLogger.debug) {
      if (_data.length < _maxLength)
        _data.insert(0, data);
      else {
        _data.removeLast();
        _data.insert(0, data);
      }
    }
  }

  /// clear all logger
  static clear() => _data.clear();
}
