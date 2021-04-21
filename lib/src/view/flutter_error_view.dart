import 'package:flutter/material.dart';

class FlutterErrorView extends StatefulWidget {
  final FlutterErrorDetails details;
  FlutterErrorView({Key? key, required this.details}) : super(key: key);

  @override
  _FlutterErrorViewState createState() => _FlutterErrorViewState();
}

class _FlutterErrorViewState extends State<FlutterErrorView> {
  String get exceptionValue {
    if (widget.details.exception is AssertionError) {
      return (widget.details.exception as AssertionError).message.toString();
    } else
      return widget.details.exception.toString();
  }

  List<String> get _stringList {
    return widget.details.stack.toString().split('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Error'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SelectableText(
                exceptionValue,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return Text(_stringList[index]);
              },
              separatorBuilder: (context, index) => SizedBox(height: 5),
              itemCount: _stringList.length,
            ),
          ),
        ],
      ),
    );
  }
}
