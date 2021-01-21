import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/view/dio_response_view.dart';

class DioResponseBuilder extends StatefulWidget {
  final Response data;
  DioResponseBuilder({Key key, this.data}) : super(key: key);

  @override
  _DioResponseBuilderState createState() => _DioResponseBuilderState();
}

class _DioResponseBuilderState extends State<DioResponseBuilder> {
  RequestOptions get _request => widget?.data?.request;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: false,
      closedBuilder: (context, action) {
        return Material(
          color: Colors.green.withOpacity(0.1),
          child: ListTile(
            onTap: action,
            title: Text(_request.path),
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
      },
      openBuilder: (context, action) => DioResponseView(data: widget.data),
    );
  }
}
