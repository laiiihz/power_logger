import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/view/dio_error_view.dart';

class DioErrorBuilder extends StatefulWidget {
  final DioError data;
  DioErrorBuilder({Key key, @required this.data}) : super(key: key);

  @override
  _DioErrorBuilderState createState() => _DioErrorBuilderState();
}

class _DioErrorBuilderState extends State<DioErrorBuilder> {
  RequestOptions get _request => widget?.data?.request;

  String renderErrText(DioErrorType type) {
    switch (type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return '连接超时';
        break;
      case DioErrorType.SEND_TIMEOUT:
        return '发送超时';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return '接收超时';
        break;
      case DioErrorType.RESPONSE:
        return 'Serve Side Error';
        break;
      case DioErrorType.CANCEL:
        return '取消连接';
        break;
      case DioErrorType.DEFAULT:
        return '未知错误';
        break;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) return ListTile(title: Text('NULL Dio Error'));
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(5),
      color: Colors.red[100],
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DioErrorView(data: widget.data),
                ),
              );
            },
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
          Row(
            children: [
              SizedBox(width: 24),
              Text(widget.data.type.toString()),
              Spacer(),
              Chip(
                backgroundColor: Colors.red.withOpacity(0.3),
                label: Text(renderErrText(widget.data.type)),
              ),
              SizedBox(width: 24),
            ],
          ),
        ],
      ),
    );
  }
}
