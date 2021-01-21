import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioErrorBuilder extends StatefulWidget {
  final DioError data;
  DioErrorBuilder({Key key, @required this.data}) : super(key: key);

  @override
  _DioErrorBuilderState createState() => _DioErrorBuilderState();
}

class _DioErrorBuilderState extends State<DioErrorBuilder> {
  RequestOptions get _request => widget?.data?.request;
  @override
  Widget build(BuildContext context) {
    if (widget.data == null) return ListTile(title: Text('NULL Dio Error'));
    return Material(
      color: Colors.red.withOpacity(0.1),
      child: ListTile(
        onTap: () {},
        title: Text(
          _request.path,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          widget.data.message,
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w300,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              backgroundColor: Colors.green.withOpacity(0.8),
              label: Text(_request.method),
            ),
          ],
        ),
      ),
    );
  }
}
