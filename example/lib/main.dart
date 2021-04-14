import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/power_logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PowerLogger\nDemo',
      home: MyHomePage(title: 'PowerLogger Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textController =
      TextEditingController(text: 'https://');
  @override
  void initState() {
    super.initState();
    NetTool.init();
    NetTool.dio.get("https://192.168.31.255:8888");
    NetTool.dio.get("https://www.baidu.com", queryParameters: {'test': 'test'});
    NetTool.dio.get("https://www.baidu.com/ahefbawfbe.html");
    NetTool.dio.post("https://www.baidu.com/ahefbawfbe.html",
        data: FormData.fromMap({'test': 'test'}));
    NetTool.dio.get(
        "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png");
    PowerLogger.start(context);
    LoggerData.addData('TEST', tag: 'TAG');
  }

  bool loading = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            filled: true,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white))
            : Icon(Icons.send),
        label: Text('发送'),
        onPressed: loading
            ? null
            : () async {
                loading = true;
                setState(() {});
                await NetTool.dio.get(_textController.text).catchError((e) {});
                loading = false;
                setState(() {});
              },
      ),
    );
  }
}

class NetTool {
  static Dio dio = Dio();
  static init() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        LoggerData.addData(response);
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        LoggerData.addData(e);
        return handler.next(e);
      },
    ));
  }
}
