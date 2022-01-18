import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

