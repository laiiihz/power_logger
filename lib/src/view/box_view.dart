import 'package:flutter/material.dart';

///BoxView
class BoxView extends StatelessWidget {
  final Widget title;
  final Widget? child;
  final List<Widget>? children;
  const BoxView({
    Key? key,
    this.child,
    required this.title,
    this.children,
  })  : assert(child != null || children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.caption!,
            child: title,
          ),
          child == null ? SizedBox() : SizedBox(height: 10),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2!,
            child: child ?? SizedBox(),
          ),
          children == null ? SizedBox() : SizedBox(height: 10),
          ...children ?? [],
        ],
      ),
    );
  }
}
