import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
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
  bool _showRawData = false;
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

  _buildMap(dynamic params) {
    if (params is FormData) {
      Map<String, dynamic> formData = {};
      formData.addEntries(params.fields);
      return BoxView(
        title: Text('FormData'),
        child: TableView(map: formData),
      );
    }
    return params?.isEmpty ?? true
        ? const SizedBox()
        : BoxView(
            title: Text('Params'),
            child: TableView(map: params),
          );
  }

  _buildData() {
    if (widget.data.data is Map)
      return BoxView(
        title: Text('Data'),
        child: HighlightView(
          prettyJson(widget.data.data),
          language: 'json',
          theme: atomOneLightTheme,
        ),
      );
    else
      return BoxView(
        title: Text('Raw'),
        child: HighlightView(
          widget.data.data,
          language: 'html',
          theme: atomOneLightTheme,
        ),
      );
  }

  _buildRawData() {
    return BoxView(
      title: Text('Raw Data'),
      child: SelectableText(widget.data.data),
    );
  }

  _buildSingleText(String title, String data) {
    return data == null || data.length == 0
        ? SizedBox()
        : BoxView(
            title: Text('Params'),
            child: SelectableText(data.toString()),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text(widget.data.request.path),
        actions: [
          Chip(
            label: Text(widget.data.request.method),
            backgroundColor: Colors.lightGreen,
          ),
          SizedBox(width: 8),
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
          SwitchListTile(
            value: _showRawData,
            title: Text('RawData'),
            onChanged: (state) => setState(() => _showRawData = state),
          ),
          AnimatedCrossFade(
            firstChild: _buildRawData(),
            secondChild: _buildData(),
            crossFadeState: _showRawData
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 500),
            firstCurve: Curves.easeInOutCubic,
            secondCurve: Curves.easeInOutCubic,
            sizeCurve: Curves.easeInOutCubic,
          ),
        ],
      ),
    );
  }
}
