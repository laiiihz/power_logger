import 'package:flutter/material.dart';

class TableView extends StatelessWidget {
  final Map map;
  const TableView({Key key, @required this.map}) : super(key: key);
  Widget _buildTableTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SelectableText(title),
    );
  }

  Map<String, dynamic> get _map => map ?? {};

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(horizontalInside: BorderSide(color: Colors.black12)),
      children: [
        TableRow(
          children: [
            _buildTableTitle('KEY'),
            _buildTableTitle('VALUE'),
          ],
        ),
        ..._map.entries
            .map((e) => TableRow(
                  children: [
                    _buildTableTitle(e.key.toString()),
                    _buildTableTitle(e.value.toString()),
                  ],
                ))
            .toList(),
      ],
    );
  }
}
