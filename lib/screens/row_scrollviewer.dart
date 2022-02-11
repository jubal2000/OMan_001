import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';

class RowScrollViewer extends StatefulWidget {
  const RowScrollViewer({Key? key, required this.title, required this.itemList}) : super(key: key);

  final String title;
  final List<String> itemList;

  @override
  State<StatefulWidget> createState() => RowScrollState();
}

class RowScrollState extends State<RowScrollViewer> {
  final PageController _controller = PageController(
      viewportFraction: 1, keepPage: true);
  final _textHeight = 30.0;
  final _itemWidth = 125.0;
  final _itemHeight = 250.0;

  List<Container> _itemList = [];

  void moveBack() {
    _controller.animateToPage(_controller.page!.toInt() - 1,
        duration: Duration(milliseconds: SCROLL_SPEED),
        curve: Curves.easeInQuad);
  }

  void moveNext() {
    _controller.animateToPage(_controller.page!.toInt() + 1,
        duration: Duration(milliseconds: SCROLL_SPEED),
        curve: Curves.easeInQuad);
  }

  @override
  void initState() {
    _itemList = widget.itemList.map((imagePath) =>
        Container(
          width: _itemWidth,
          height: _itemHeight,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(imagePath),
          ),
        )).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(
          children: [
            Container(
              height: _textHeight,
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline2
              ),
            ),
            Container(
                height: _itemHeight,
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: _itemList,
                      )
                  ),
                )
            ),
          ],
        )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}