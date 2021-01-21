class LoggerData {
  static int _maxLength = 100;

  static List<dynamic> _data = [];

  static List<dynamic> get data => _data;
  static setMax(int max) {
    _maxLength = max ?? 100;
  }

  static addData(dynamic data) {
    if (_data.length < _maxLength)
      _data.insert(0, data);
    else {
      _data.removeLast();
      _data.insert(0, data);
    }
  }

  static clear() => _data.clear();
}
