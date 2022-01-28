import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/history_item.dart';
import 'package:oman_001/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class PlayerOverlayScreen extends StatefulWidget {
  final VideoPlayerController? controller;
  final Function? onScreenClosed;
  HistoryItem itemData;

  PlayerOverlayScreen(
      this.itemData,
      { Key? key, this.controller, this.onScreenClosed }) : super(key: key);

  @override
  PlayerOverlayState createState() => PlayerOverlayState();
}

class PlayerOverlayState extends State<PlayerOverlayScreen> {
  var _height     = 0.0;
  var _width      = 0.0;
  var _curPos     = Duration();
  var _maxPos     = Duration();
  var _isPlaying  = AppData.isMainPlay;
  var _isActive   = false;

  get _listener => () {
    if (_isActive) {
      setState(() {
        if (widget.controller == null) return;
        _isPlaying = widget.controller!.value.isPlaying;
        _curPos = widget.controller!.value.position;
        // print("--> _listener : $_isPlaying - $_curPos / $_maxPos");

        if (_curPos == _maxPos) {
          _curPos = Duration();
          _isPlaying = false;
          // 플레이가 끝나면 자동으로 overlay 화면 보여줌..
          widget.onScreenClosed!(true);
        // } else if (!AppData.isMainPlay && _isPlaying) {
        //     widget.controller!.pause();
        }
      });
    }
  };

  @override
  void initState() {
    super.initState();
    if (!_isActive) widget.controller!.addListener(_listener);
    _isActive = true;
  }

  @override
  void dispose() {
    super.dispose();
    _isActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          _height = 180;
          _width = MediaQuery
              .of(context)
              .size
              .width * 0.8;
          _maxPos = widget.controller!.value.duration;

          List<LineMetrics> lines = _textSize(widget.itemData.title!, Theme.of(context).textTheme.headline1!, 2).computeLineMetrics();
          int titleLines = lines.length;

          return Container(
              height: _height,
              width: _width,
              margin: EdgeInsets.only(bottom: 10, left: 10),
              padding: EdgeInsets.all(10),
              color: Colors.grey.withOpacity(0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      width: 130,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/ui/player_button_bg_mini_00.png"), fit: BoxFit.fill),
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    print("--> _isPlaying : ${widget.controller!.value.isPlaying}");
                                    widget.controller!.value.isPlaying ?
                                    { widget.controller!.pause(), AppData.isMainPlay = false } :
                                    { widget.controller!.play(), AppData.isMainPlay = true, _curPos = Duration() };
                                  });
                                },
                                icon: Image.asset(_isPlaying && AppData.isMainPlay
                                    ? "assets/ui/main_player_01.png"
                                    : "assets/ui/main_player_00.png")
                              )
                            ),
                            SizedBox(width: 10),
                            Text(
                              _curPos.minuteSecondFormatted(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              " / " + _maxPos.minuteSecondFormatted(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        )
                      )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          widget.itemData.title!,
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 1,
                        ),
                    ),
                    Text(
                        widget.itemData.desc!,
                        maxLines: 5 - titleLines,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline5,
                    ),
                ]
            )
          );
        });
  }

  TextPainter _textSize(String text, TextStyle style, int maxLine) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: maxLine, textDirection: TextDirection.ltr)
      ..layout(minWidth: _width, maxWidth: _width);
    return textPainter;
  }
}


