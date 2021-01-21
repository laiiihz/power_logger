import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  final Widget title;
  const TitleView({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 24,
          color: Colors.black45,
          fontWeight: FontWeight.w600,
        ),
        child: title,
      ),
    );
  }
}
