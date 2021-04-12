import 'package:dio/dio.dart';

/// original http content type.
enum ContentType {
  TEXT_PLAIN,
  TEXT_HTML,
  TEXT_CSS,
  TEXT_JS,
  IMAGE,
  AUDIO,
  VIDEO,
  JSON,
  UNCATCH,
}

/// Dio parse
class DioParser {
  Response? _response;
  DioParser(Response? response) {
    _response = response;
  }

  /// get dio request
  RequestOptions get request => _response!.requestOptions;

  /// get dio response
  Response? get response => _response;

  /// get dio contentType
  ContentType get type {
    String _ctype = _response!.headers.map['content-type']!.first;

    if (_ctype.contains('text/plain')) return ContentType.TEXT_PLAIN;
    if (_ctype.contains('text/html')) return ContentType.TEXT_HTML;
    if (_ctype.contains('text/css')) return ContentType.TEXT_CSS;
    if (_ctype.contains('text/javascript')) return ContentType.TEXT_JS;
    if (_ctype.contains('application/json')) return ContentType.JSON;
    if (_ctype.contains('image/')) return ContentType.IMAGE;
    if (_ctype.contains('audio/')) return ContentType.AUDIO;
    if (_ctype.contains('video/')) return ContentType.VIDEO;
    if (_ctype.contains('application/json'))
      return ContentType.JSON;
    else
      return ContentType.UNCATCH;
  }

  /// get highlight type.
  String get highlight {
    switch (type) {
      case ContentType.TEXT_HTML:
        return 'html';
      case ContentType.TEXT_CSS:
        return 'css';
      case ContentType.TEXT_JS:
        return 'javascript';
      case ContentType.JSON:
        return 'json';
      default:
        return '';
    }
  }
}
