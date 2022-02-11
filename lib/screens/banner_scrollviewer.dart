import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';
import 'dart:async';

class BannerScrollViewer extends StatefulWidget {
  BannerScrollViewer(this.itemList, {Key? key,
    this.title = "",
    this.titleStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.titleHeight = 50.0,
    this.titleBackColor = Colors.white,
    this.titleAlign = Alignment.center,
    this.rowHeight = 200.0,
    this.margin = const EdgeInsets.only(bottom: 10),
    this.backgroundColor = Colors.black,
    this.autoScrollTime = 5,
    this.autoScroll = true,
    this.showArrow = true
  }) : super(key: key);

  final List<String> itemList;
  String      title;
  TextStyle   titleStyle;
  double      titleHeight;
  Color       titleBackColor;
  Alignment   titleAlign;
  double      rowHeight;
  EdgeInsets  margin;
  Color       backgroundColor;
  int         autoScrollTime;
  bool        autoScroll;
  bool        showArrow;

  var currentPage = 0;

  @override
  State<StatefulWidget> createState() => BannerScrollState();
}

class BannerScrollState extends State<BannerScrollViewer> {
  final PageController _controller = PageController(viewportFraction: 1, keepPage: true);
  var _isDragging = false;
  var _startPos = Offset(0, 0);
  Timer? _timer;

  void bannerBack() {
    _controller.animateToPage(_controller.page!.toInt()-1, duration: Duration(milliseconds: SCROLL_SPEED), curve: Curves.fastOutSlowIn);
  }

  void bannerNext() {
    _controller.animateToPage(_controller.page!.toInt()+1, duration: Duration(milliseconds: SCROLL_SPEED), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autoScroll && _timer == null) {
      _timer = Timer.periodic(Duration(seconds: widget.autoScrollTime), (timer) {
        if (_controller.page!.toInt()+1 >= widget.itemList.length) {
          _controller.animateToPage(0, duration: Duration(milliseconds: SCROLL_SPEED), curve: Curves.fastOutSlowIn);
        } else {
          bannerNext();
        }
      });
    }
    return Column(
        children: [
          Visibility(
            visible: widget.title.isNotEmpty,
            child: Container(
              height: widget.titleHeight,
              color: widget.titleBackColor,
              alignment: widget.titleAlign,
              child: Text(
                  widget.title,
                  style: widget.titleStyle
              ),
            ),
          ),
          Container(
            height: widget.rowHeight,
            color: widget.backgroundColor,
            margin: widget.margin,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: widget.itemList.length,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      // print("--> onPageChanged : $index");
                      widget.currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    index = index % widget.itemList.length;
                    return GestureDetector(
                      // child: MainHomeCard(_homeList[index].user, _homeList[index].historyId),
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Image.asset(widget.itemList[index])
                      ),
                      onHorizontalDragStart: (pos) {
                        _startPos = pos.localPosition;
                        _isDragging = true;
                      },
                      onHorizontalDragUpdate: (pos) {
                        if (!_isDragging) return;
                        // print("--> page : ${controller.page!.toInt()} / ${_startPos.dx} < ${pos.localPosition.dx}");
                        if (_startPos.dx < pos.localPosition.dx) {
                          bannerBack();
                        } else {
                          bannerNext();
                        }
                        _isDragging = false;
                      },
                    );
                  },
                ),
                Visibility(
                  visible: widget.showArrow,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: widget.currentPage-1 >= 0 ? Colors.white : Colors.transparent),
                          onPressed: () {
                            bannerBack();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, color: widget.currentPage+1 < widget.itemList.length ? Colors.white : Colors.transparent),
                          onPressed: () {
                            bannerNext();
                          },
                        ),
                      ],
                    )
                  ),
                ),
              ]
            ),
          ),
        ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}