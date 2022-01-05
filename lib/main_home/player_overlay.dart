import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class PlayerOverlayScreen extends StatelessWidget {
  final VideoPlayerController? _controller;
  final Function? _onScreenClosed;

  PlayerOverlayScreen(this._controller, this._onScreenClosed);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      color: Colors.grey.withOpacity(0.9),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) {
          print("--> _onScreenClosed !!");
          _onScreenClosed!();
        },
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
                    // 영상이 재생 중이라면, 일시 중지 시킵니다.
                    if (_controller!.value.isPlaying) {
                      _controller!.pause();
                    } else {
                      // 만약 영상이 일시 중지 상태였다면, 재생합니다.
                      _controller!.play();
                    }
                  },
                  child: Icon(
                    _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
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
      )
    );
  }
}


