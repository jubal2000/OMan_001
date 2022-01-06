import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class PlayerOverlayScreen extends StatefulWidget {
  final VideoPlayerController? controller;
  final Function? onScreenClosed;

  const PlayerOverlayScreen({
    Key? key,
    this.controller,
    this.onScreenClosed
  }) : super(key: key);

  @override
  PlayerOverlayState createState() => PlayerOverlayState();
}

class PlayerOverlayState extends State<PlayerOverlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width * 0.3,
        width: MediaQuery.of(context).size.width * 0.7,
        margin: EdgeInsets.only(bottom: 10.0, left: 30),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.grey.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // 재생/일시 중지 기능을 `setState` 호출로 감쌉니다. 이렇게 함으로써 올바른 아이콘이
                    // 보여집니다.
                    setState(() {
                      widget.controller!.value.isPlaying ? widget.controller!
                          .pause() : widget.controller!.play();
                    });
                  },
                  child: Icon(
                    widget.controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  )
                ),
                SizedBox(width: 5),
                Text(
                  "00:00 ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "/ 00:00",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            )
          ]
        )
      );
  }
}


