import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';

class CategoryViewer extends StatefulWidget {
  CategoryViewer( this.itemList, {Key? key,
    this.title = "",
    this.titleStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.titleHeight = 30.0,
    this.titleBackColor = Colors.white,
    this.titleAlign = Alignment.centerLeft,
    this.margin = const EdgeInsets.all(10),
    this.backgroundColor = Colors.black,
    this.viewColumn = 1,
    this.maxColumn = 2,
    this.maxRows = 5,
    this.space = 10,
  }) : super(key: key);

  final List<CategoryViewerItem> itemList;

  String      title;
  TextStyle   titleStyle;
  double      titleHeight;
  Color       titleBackColor;
  Alignment   titleAlign;
  EdgeInsets  margin;
  Color       backgroundColor;

  int viewColumn;
  int maxColumn;
  int maxRows;
  double space;

  var isOpen = false;

  @override
  State<StatefulWidget> createState() => CategoryViewerState();
}

class CategoryViewerState extends State<CategoryViewer> {
  final List<List<Widget>> _itemList = [];
  var _itemHeight = 100.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _itemHeight = (MediaQuery.of(context).size.width - widget.margin.left - widget.margin.right - (widget.space * (widget.maxRows - 1))) / widget.maxRows;
    print("  --> _itemList.length : ${_itemList.length} / $_itemHeight");
    List<Widget> _itemLineList = [];
    Widget? _itemShowList;

    // here for itemHeight..
    _itemList.clear();
    var count = 0;
    for (CategoryViewerItem item in widget.itemList) {
      if (count++ >= widget.maxRows) {
        _itemList.add(_itemLineList);
        _itemLineList = [];
        count = 0;
      } else {
        item.height = _itemHeight;
        item.width  = _itemHeight;
        item.backgroundColor = Colors.grey.withOpacity(0.1);
        item.textStyle = AppData.MainTheme.textTheme.bodyText1!;
        item.textAlignment = Alignment.bottomCenter;
        item.textMargin = EdgeInsets.symmetric(vertical: _itemHeight * 0.1);
        if (count > 1) _itemLineList.add(SizedBox(width: widget.space, height: widget.space));
        _itemLineList.add(item);
      }
    }

    if (_itemLineList.isNotEmpty) _itemList.add(_itemLineList);
    return Container(
      margin: widget.margin,
      child: Column(
        children: [
          Visibility(
            visible: widget.title.isNotEmpty,
            child: Container(
              height: widget.titleHeight,
              color: widget.titleBackColor,
              alignment: widget.titleAlign,
              margin: EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isOpen = !widget.isOpen;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: widget.titleStyle
                    ),
                    Icon(
                      widget.isOpen ? Icons.expand_less : Icons.expand_more,
                      size: 30,
                    )
                  ]
                ),
              ),
            ),
          ),
          AnimatedSize(
            alignment: Alignment.topLeft,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            child: SizedBox(
              height: widget.isOpen ? (_itemHeight + widget.space) * _itemList.length - widget.space : _itemHeight,
              child: itemListExt,
            ),
          )
        ],
      ),
    );
  }

  Widget get itemListExt {
    List<Widget> _tmpList = [];
    for (var i=0; i<_itemList.length; i++) {
      if (i > 0) {
        _tmpList.add(SizedBox(width: widget.space, height: widget.space));
      }
      _tmpList.add(Row(children: _itemList[i]));
      if (!widget.isOpen) break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _tmpList,
    );
  }
}

class CategoryViewerItem extends StatelessWidget {
  CategoryViewerItem(this.text, {Key? key,
    this.image,
    this.width  = 50.0,
    this.height = 50.0,
    this.backgroundColor = Colors.white,
    this.textAlignment  = Alignment.center,
    this.textStyle      = const TextStyle(fontSize: 10, color: Colors.black),
    this.textMargin     = const EdgeInsets.all(0),
  }) : super(key: key);

  Image?    image;
  IconData? icon;
  String?   text;

  TextStyle   textStyle;
  Color       backgroundColor;
  Alignment   textAlignment;
  EdgeInsets  textMargin;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width:  width,
          height: height,
          color:  backgroundColor,
          child: GestureDetector(
            onTap : (() {
              print("--> GestureDetector $text");
            }),
            child: Column(
              children: [
                Visibility(
                  visible: icon != null,
                  child: Icon(
                    icon,
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: textAlignment,
                      margin: textMargin,
                      child: Text(
                        text!,
                        style: textStyle,
                      )
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
