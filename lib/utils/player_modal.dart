import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class PlayerModalScreen extends ModalRoute<void> {
  PlayerModalScreen(this._controller, this.onScreenHideButtonPressed);
  final VideoPlayerController? _controller;
  final Function? onScreenHideButtonPressed;
  final dialogContextCompleter = Completer<BuildContext>();

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  close() async {
    final dialogContext = await dialogContextCompleter.future;
    Navigator.pop(dialogContext);
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      color: Colors.grey.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Center(
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // 재생/일시 중지 기능을 `setState` 호출로 감쌉니다. 이렇게 함으로써 올바른 아이콘이
                    // 보여집니다.
                    setState(() {
                      // 영상이 재생 중이라면, 일시 중지 시킵니다.
                      if (_controller!.value.isPlaying) {
                        _controller!.pause();
                      } else {
                        // 만약 영상이 일시 중지 상태였다면, 재생합니다.
                        _controller!.play();
                      }
                    });
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
                ElevatedButton(
                  onPressed: () {
                    onScreenHideButtonPressed!();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Return",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ]
      )
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}


