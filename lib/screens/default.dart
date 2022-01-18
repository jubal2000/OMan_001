import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultViewer extends StatefulWidget {
  DefaultViewer(this.itemList, {Key? key,
    this.title = "",
    this.titleStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.titleHeight = 50.0,
    this.titleBackColor = Colors.white,
    this.rowHeight = 200.0,
    this.margin = const EdgeInsets.all(10),
    this.backgroundColor = Colors.black,
    this.viewColumn = 1,
    this.maxColumn = 2,
    this.maxRows = 5,
  }) : super(key: key);

  final List<String> itemList;
  String      title;
  TextStyle   titleStyle;
  double      titleHeight;
  Color       titleBackColor;
  double      rowHeight;
  EdgeInsets  margin;
  Color       backgroundColor;

  int viewColumn;
  int maxColumn;
  int maxRows;

  @override
  State<StatefulWidget> createState() => DefaultViewerState();
}

class DefaultViewerState extends State<DefaultViewer> {
  bool _isOn = false;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
