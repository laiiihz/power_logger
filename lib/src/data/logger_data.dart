import 'package:flutter/foundation.dart';
import 'package:power_logger/power_logger.dart';

/// logger data storage
class LoggerData {
  static int _maxLength = 100;

  /// the real logger data.
  static List<dynamic> get data => _listenableData.value;

  static _LoggerDataNotifer<List<dynamic>> _listenableData =
      _LoggerDataNotifer([]);

  /// set the logger max number.
  static setMax(int max) {
    _maxLength = max ?? 100;
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
  }

  /// clear all logger
  static clear() => _listenableData.value.clear();

  /// add data listener
  static addListener(Function listener) {
    _listenableData.addListener(listener);
  }

  /// remove data listener
  static removeListener(Function listener) {
    _listenableData.removeListener(listener);
  }
}

class _LoggerDataNotifer<T> extends ValueNotifier {
  _LoggerDataNotifer(value) : super(value);
  notify() => this.notifyListeners();
}
