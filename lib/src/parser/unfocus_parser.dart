import 'package:flutter/material.dart';

class UnfocusParser extends StatelessWidget {
  final dynamic data;
  const UnfocusParser({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(data.toString()),
      trailing: Chip(
        label: Text(data.runtimeType.toString()),
      ),
    );
  }
}
