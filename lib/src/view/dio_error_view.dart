import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/view/box_view.dart';
import 'package:power_logger/src/view/table_view.dart';
import 'package:power_logger/src/view/title_view.dart';

class DioErrorView extends StatefulWidget {
  final DioError data;
  DioErrorView({Key key, @required this.data}) : super(key: key);

  @override
  _DioErrorViewState createState() => _DioErrorViewState();
}

class _DioErrorViewState extends State<DioErrorView> {
  RequestOptions get _request => widget.data.requestOptions;
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
      title: const Text('Type'),
      child: Chip(
        label: Text(widget.data.type.toString()),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Text(widget.data.requestOptions.path),
        actions: [
          Chip(
            label: Text(widget.data.requestOptions.method),
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
          _buildStatus(),
        ],
      ),
    );
  }
}
