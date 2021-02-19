import 'package:flutter/material.dart';

/// UnfocusParser
class UnfocusParser extends StatelessWidget {
  final dynamic data;
  const UnfocusParser({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(5),
      child: ListTile(
        onTap: () {},
        title: Text(data.toString()),
        trailing: Chip(
          label: Text(data.runtimeType.toString()),
        ),
      ),
    );
  }
}
