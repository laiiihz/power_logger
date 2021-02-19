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
  Response _response;
  DioParser(Response response) {
    _response = response;
  }

  /// get dio request
  RequestOptions get request => _response.request;

  /// get dio response
  Response get response => _response;

  /// get dio contentType
  ContentType get type {
    String _ctype = response.headers.map['content-type'].first;
    switch (_ctype) {
      case 'text/plain':
        return ContentType.TEXT_PLAIN;
      case 'text/html':
        return ContentType.TEXT_HTML;
      case 'text/css':
        return ContentType.TEXT_CSS;
      case 'text/javascript':
        return ContentType.TEXT_JS;
      case 'application/json':
        return ContentType.JSON;
    }
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
