import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:power_logger/src/view/box_view.dart';
import 'package:power_logger/src/view/table_view.dart';
import 'package:power_logger/src/view/title_view.dart';
import 'package:pretty_json/pretty_json.dart';

class DioResponseView extends StatefulWidget {
  final Response data;
  DioResponseView({Key key, @required this.data}) : super(key: key);

  @override
  _DioResponseViewState createState() => _DioResponseViewState();
}

class _DioResponseViewState extends State<DioResponseView> {
  RequestOptions get _request => widget.data.request;
  _buildBaseURL() {
    return _request.baseUrl == null || _request.baseUrl.length == 0
        ? const SizedBox()
        : BoxView(
            title: Text('BaseURL'),
            child: Text(_request.baseUrl),
          );
  }

  _buildPath() {
    return BoxView(
      title: const Text('Path'),
      child: Text(_request.path),
    );
  }

  _buildStatus() {
    return BoxView(
      title: const Text('Status'),
      children: [
        Chip(
          label: Text(widget.data.statusCode.toString()),
        ),
        Text(widget.data.statusMessage),
      ],
    );
  }

  _buildMap(Map<String, dynamic> params) {
    return params?.isEmpty ?? true
        ? const SizedBox()
        : BoxView(
            title: Text('Params'),
            child: TableView(map: params),
          );
  }

  _buildData() {
    return BoxView(
      title: Text('Params'),
      child: HighlightView(
        widget.data.data.toString(),
        language: 'json',
        theme: githubTheme,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.request.path),
        actions: [
          Chip(
            label: Text(widget.data.request.method),
            backgroundColor: Colors.lightGreen,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          TitleView(title: Text('Request')),
          _buildBaseURL(),
          _buildPath(),
          _buildMap(_request.headers),
          _buildMap(_request.queryParameters),
          _buildMap(_request.data),
          TitleView(title: Text('Response')),
          _buildMap(widget.data.headers.map),
          _buildStatus(),
          _buildData(),
        ],
      ),
    );
  }
}
