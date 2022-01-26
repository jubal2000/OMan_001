import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';

// typedef void ValueCallback(int value);

class NumberInputWidget extends StatefulWidget {
  NumberInputWidget(this.number, {Key? key, this.onChanged, this.min = 1, this.max = 99, this.step = 1, this.iconSize = 24}) : super (key: key);

  int number;
  int min;
  int max;
  int step;
  double iconSize;

  void Function(int)? onChanged;

  @override
  _NumberInputWidgetState createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends State<NumberInputWidget> {
  var _height;
  var _width;

  onChangeValue() {
    widget.onChanged!(widget.number);
  }

  onAdd() {
    setState(() {
      if (++widget.number > widget.max) widget.number = widget.max;
    });
    onChangeValue();
  }

  onSub() {
    setState(() {
      if (--widget.number < widget.min) widget.number = widget.min;
    });
    onChangeValue();
  }

  @override
  void initState() {
    super.initState();
    _height = widget.iconSize * 1.5;
    _width = _height * 3.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(color: Colors.grey, width: 1),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: _width * 0.3,
                  child: IconButton(
                    onPressed: onSub,
                    color: Colors.grey,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.remove, size: widget.iconSize),
                  ),
                ),
                Expanded(
                  child: Text("${widget.number}", style: AppData.MainTheme.textTheme.headline1, textAlign: TextAlign.center, maxLines: 1),
                ),
                SizedBox(
                  width: _width * 0.3,
                  child: IconButton(
                    onPressed: onAdd,
                    color: Colors.grey,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add, size: widget.iconSize),
                  ),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}