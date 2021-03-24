import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:power_logger/power_logger.dart';

/// logger data storage
class LoggerData {
  static int _maxLength = 100;

  static bool _markLogger = false;
  static bool get markLogger => _markLogger;
  static setLogger(bool state) {
    _markLogger = state;
  }

  static Logger _logger = Logger();

  /// the real logger data.
  static List<dynamic> get data => _listenableData.value;

  static _LoggerDataNotifer<List<dynamic>> _listenableData =
      _LoggerDataNotifer([]);

  /// set the logger max number.
  static setMax(int max) {
    _maxLength = max;
  }

  /// add data to logger
  static addData(dynamic data) {
    if (PowerLogger.debug) {
      if (_listenableData.value.length < _maxLength) {
        _listenableData.value.insert(0, data);
        _listenableData.notify();
      } else {
        _listenableData.value.removeLast();
        _listenableData.value.insert(0, data);
        _listenableData.notify();
      }
    }

    if (_markLogger) _logger.i(data);
  }

  /// clear all logger
  static clear() => _listenableData.value.clear();

  /// add data listener
  static addListener(Function listener) {
    _listenableData.addListener(listener as void Function());
  }

  /// remove data listener
  static removeListener(Function listener) {
    _listenableData.removeListener(listener as void Function());
  }
}

class _LoggerDataNotifer<T> extends ValueNotifier {
  _LoggerDataNotifer(value) : super(value);
  notify() => this.notifyListeners();
}
