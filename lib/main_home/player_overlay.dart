import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class PlayerOverlayScreen extends StatefulWidget {
  final VideoPlayerController? controller;
  final Function? onScreenClosed;
  final titleText = "비밀번호 asdf가 많은이유";
  final descText = "지금도 생성되고 있을 인터넷 상의 수많은 아이디와 비밀번호."
      "할 말이 없을 때도 쓰기도 한다."
      "왜 하필 asdf인가 하면, QWERTY 자판 기준으로 키보드에 제일 먼저 왼손이 닿는 부위가 순서대로 A, S, D, F이기 때문이다.[1] 드보락 자판에서는 이 부분이 aoeu가 되며, 콜맥 자판에서는 arst가 된다. 비슷한 경우로 ㅁㄴㅇㄹ과 qwer 따위도 존재한다."
      "HTML에서 색상코드를 #asdf로 주면 이런 색상(■, 실제 코드 #A0DF00)으로 인식한다. 색상코드가 4자리로 주어진 경우 HTML에서는 앞 2자리를 R,"
      "뒤 2자리를 G에 배당하고 B값은 0으로 간주하기 때문. 여기서는 16진수에 쓰지 않는 문자인 S 부분을 0으로 처리했기에 이런 코드가 나온 것이다. 단 이것은 HTML 코드에 직접 썼을 때 한정이며 나무위키에서 문법으로 대놓고 #asdf라고 쓰면 인식하지 않아서 그냥 검은색으로 뜬다."
      "#asdf ■ 이렇게. 실제로 html에 나온 것처럼 하려면 {{{#a0df00 }}} 이렇게 써야 한다.";

  const PlayerOverlayScreen({
    Key? key,
    this.controller,
    this.onScreenClosed
  }) : super(key: key);

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
        _isPlaying = widget.controller!.value.isPlaying;
        _curPos = widget.controller!.value.position;
        if (_curPos.compareTo(_maxPos) == 0) {
          _curPos = Duration();
          _isPlaying = false;
          // 플레이가 끝나면 자동으로 overlay 화면 보여줌..
          widget.onScreenClosed!(true);
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
          _height = 150;
          _width = MediaQuery
              .of(context)
              .size
              .width * 0.7;
          _maxPos = widget.controller!.value.duration;

          TextStyle titleStyle = TextStyle(
              color: Colors.white,
              fontSize: 14,
          );

          Text titleTextBlock = Text(
              widget.titleText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: titleStyle,
          );

          List<LineMetrics> lines = _textSize(widget.titleText, titleStyle, 2).computeLineMetrics();
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
                                    _isPlaying ? widget
                                        .controller!
                                        .pause() : { widget.controller!.play(), _curPos = Duration() };
                                    AppData.isMainPlay = _isPlaying;
                                  });
                                },
                                icon: Image.asset(_isPlaying
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
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: titleTextBlock,
                    ),
                    Text(
                        widget.descText,
                        maxLines: 5 - titleLines,
                        // when user presses enter it will adapt to it
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0,
                        )
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


