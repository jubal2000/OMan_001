import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/history_item.dart';


INT(dynamic value, {int defaultValue = 0}) {
  return value != null && value.toString().isNotEmpty ? int.parse(value.toString()) : defaultValue;
}

STR(dynamic value, {dynamic defaultValue = ''}) {
  return value != null ? value!.toString() : defaultValue != null ? defaultValue.toString() : '';
}

TME(dynamic value, {dynamic defaultValue = ''}) {
  DateTime? result;
  try {
    result = value != null
        ? value.runtimeType == String ? DateTime.parse(value.toString()) : DateTime.fromMillisecondsSinceEpoch(value['_seconds']*1000)
        : defaultValue != null
        ? DateTime.parse(defaultValue!.toString())
        : null;
  } catch (e) {
    print("--> TME error : ${value.toString()} -> $e");
  }
  // print("--> TME result : ${result.toString()}");
  return result;
}

// MAP(dynamic value, dynamic type) {
//   Map<String, type> result = {};
//   if (value != null && value.length > 0) {
//     try {
//       for (var item in value) {
//         if (item['id'] != null) {
//           var itemId = item['id'].toString();
//           result[itemId] = item;
//           print("--> MAP add : ${item.toString()} -> $itemId");
//         }
//       }
//     } catch (e) {
//       print("--> MAP error : ${value.toString()} -> $e");
//     }
//   }
//   return result;
// }

ARR(dynamic value, dynamic data) {
  if (value != null) {
    for (var item in value) {
        data!.add(data.fromJson(item));
    }
  }
}


extension DurationFormatter on Duration {
  /// Returns a day, hour, minute, second string representation of this `Duration`.
  ///
  ///
  /// Returns a string with days, hours, minutes, and seconds in the
  /// following format: `dd:HH:MM:SS`. For example,
  ///
  ///   var d = new Duration(days:19, hours:22, minutes:33);
  ///    d.dayHourMinuteSecondFormatted();  // "19:22:33:00"
  String dayHourMinuteSecondFormatted() {
    toString();
    return [
      inDays,
      inHours.remainder(24),
      inMinutes.remainder(60),
      inSeconds.remainder(60)
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
  }

  String minuteSecondFormatted() {
    toString();
    return [
      inMinutes.remainder(60),
      inSeconds.remainder(60)
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
  }
}

class SearchHistoryModal extends StatefulWidget {
  SearchHistoryModal({Key? key}) : super (key: key);

  @override
  SearchHistoryModalState createState() => SearchHistoryModalState();
}

class SearchHistoryModalState extends State<SearchHistoryModal> {
  var _isSearchOn = false;
  List<String> _newHistoryList = [];

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _isSearchOn,
        child: SingleChildScrollView(
            child: Container(
              // color: Colors.white,
                child: Column(
                    children: _newHistoryList.map((item) =>
                        Container(
                            height: 30,
                            child: ListTile(
                                title: Text(item),
                                onTap: () {
                                  print("--> select : $item");
                                })
                        )).toList()
                )
            )
        )
    );
  }
}

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    var newSize = renderBox.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

class ListItemEx extends StatelessWidget {
  ListItemEx(this.title, {Key? key, this.isTitle = false, this.isLast = false}) : super(key: key);

  String title;
  bool isTitle;
  bool isLast;

  @override
  Widget build(BuildContext context) {
    if (isTitle) {
      return Container(
          height: 50,
          color: Colors.grey.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headline1),
            ],
          )
      );
    } else {
      return Container(
          height: 50,
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(title, style: Theme.of(context).textTheme.headline2),
                        Expanded(child: SizedBox(height: 1)),
                        Image.asset("assets/ui/arrow_right_00.png", width: 15, height: 40, color: Colors.black.withOpacity(0.75)),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !isLast,
                  child: Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
              ]
          )
      );
      // return Padding(
      //   padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(8),
      //     child: Container(
      //       height: 40,
      //       width: double.infinity,
      //       color: Colors.grey.withOpacity(0.25),
      //       alignment: Alignment.centerLeft,
      //       padding: EdgeInsets.all(10),
      //       child: Text(title, style: AppData.MainTheme.textTheme.headline2),
      //     ),
      //   ),
      // );
    }
  }
}

class MenuItem {
  final String text;
  final IconData icon;
  final bool isLast;

  const MenuItem({
    required this.text,
    required this.icon,
    this.isLast = false
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [content, store, live];
  static const List<MenuItem> secondItems = [];

  static const content = MenuItem(text: '컨텐트', icon: Icons.window);
  static const store = MenuItem(text: '스토어', icon: Icons.store);
  static const live = MenuItem(text: '라이브', icon: Icons.live_tv, isLast: true);

  static Widget buildItem(MenuItem item) {
    return Column(
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
                Icon(
                    item.icon,
                    color: Colors.grey,
                    size: 22
                ),
                SizedBox(width: 10),
                Text(item.text, style: MainTheme.textTheme.headline2),
              ],
            ),
          ),
        ),
        Visibility(
          visible: !item.isLast,
          child: Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
            indent: 0,
            endIndent: 0,
          ),
        ),
      ]
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.content:
      //Do something
        break;
      case MenuItems.store:
      //Do something
        break;
      case MenuItems.live:
      //Do something
        break;
    }
  }
}

class SecondPageRoute extends CupertinoPageRoute {
  SecondPageRoute(this.widget)
      : super(builder: (BuildContext context) => widget);

  Widget widget;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: widget);
  }
}

/// Outlines a text using shadows.
List<Shadow> outlinedText({double strokeWidth = 1, Color strokeColor = Colors.black, int precision = 4}) {
  Set<Shadow> result = HashSet();
  for (int x = 1; x < strokeWidth + precision; x++) {
    for(int y = 1; y < strokeWidth + precision; y++) {
      double offsetX = x.toDouble();
      double offsetY = y.toDouble();
      result.add(Shadow(offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY), color: strokeColor));
      result.add(Shadow(offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY), color: strokeColor));
      result.add(Shadow(offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY), color: strokeColor));
      result.add(Shadow(offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY), color: strokeColor));
    }
  }
  return result.toList();
}
