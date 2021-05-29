import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/view/box_view.dart';
import 'package:power_logger/src/view/table_view.dart';
import 'package:power_logger/src/view/title_view.dart';

class DioErrorView extends StatefulWidget {
  final DioError data;
  DioErrorView({Key? key, required this.data}) : super(key: key);

  @override
  _DioErrorViewState createState() => _DioErrorViewState();
}

class _DioErrorViewState extends State<DioErrorView> {
  RequestOptions get _request => widget.data.requestOptions;
  _buildBaseURL() {
    return _request.baseUrl.length == 0
        ? const SizedBox()
        : BoxView(
            title: Text('BaseURL'),
            child: Text(_request.baseUrl),
          );
  }

  _buildPath() {
    return BoxView(
      title: const Text('Path'),
      child: SelectableText(_request.path),
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

  _buildMessage() {
    return BoxView(
      title: const Text('Message'),
      child: Text(widget.data.message),
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
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.red[100]
            : Colors.red[900],
        title: Text(widget.data.requestOptions.path),
        actions: [
          Chip(
            label: Text(widget.data.requestOptions.method),
            backgroundColor: Colors.lightGreen.withOpacity(0.5),
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
          _buildMessage(),
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
