import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/builders/dio_responses_builder.dart';
import 'package:power_logger/src/builders/dio_error_builder.dart';
import 'package:power_logger/src/parser/unfocus_parser.dart';

class LoggerDataParser {
  static Widget builder(dynamic data) {
    if (data is DioError) return DioErrorBuilder(data: data);
    if (data is Response) return DioResponseBuilder(data: data);
    return UnfocusParser(data: data);
  }
}
