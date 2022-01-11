import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/user_item.dart';
import 'package:oman_001/main_home/player_overlay.dart';
import 'package:oman_001/main_home/user_overlay.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class MainHomeCard extends StatefulWidget {
  PageController pageController = PageController(viewportFraction: 1, keepPage: true);
  final Map<String, MainHomeCardPlayer> _itemList = {};
  final List<String> _itemIdList = [];
  final UserItem user;
  final String historyId;

  MainHomeCard(this.user, this.historyId, {Key? key}) : super(key: key) {
    for (var item in user.historyData) {
      var control = VideoPlayerController.network(item.url!);
      var initialize = control.initialize();
      _itemList[item.id!] = MainHomeCardPlayer(pageController, control, initialize);
      _itemIdList.add(item.id!);
    }
  }

  play() {

  }

  stop() {
    for (var item in _itemIdList) {
      _itemList[item]?.controller.pause();
    }
  }

  @override
  MainHomeCardState createState() => MainHomeCardState();
}

class MainHomeCardState extends State<MainHomeCard> {
  var _startPos = Offset(0, 0);
  var _isDragging = false;
  var _itemIndexOrg = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PageView.builder(
        controller: widget.pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget._itemList.length,
        onPageChanged: (index) {
          print("--> page changed : $index / $_itemIndexOrg / ${AppData.isMainPlay}");
          if (AppData.isMainPlay) {
            widget._itemList[index]?.controller.play();
          }
          if (_itemIndexOrg >= 0) {
            widget._itemList[_itemIndexOrg]?.controller.pause();
          }
          _itemIndexOrg = index;
        },
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var itemId = widget._itemIdList[index];
          if (AppData.isMainPlay) {
            widget._itemList[itemId]?.controller.play();
          }
          return widget._itemList[itemId]!;
        },
      ),
      onHorizontalDragStart: (pos) {
        _startPos = pos.localPosition;
        _isDragging = true;
      },
      onHorizontalDragUpdate: (pos) {
          if (!_isDragging) return;
          // print("--> page : ${controller.page!.toInt()} / ${_startPos.dx} < ${pos.localPosition.dx}");
          if (_startPos.dx < pos.localPosition.dx) {
            widget.pageController.animateToPage(widget.pageController.page!.toInt()-1, duration: Duration(milliseconds: 250), curve: Curves.easeInQuad);
          } else {
            widget.pageController.animateToPage(widget.pageController.page!.toInt()+1, duration: Duration(milliseconds: 250), curve: Curves.easeInQuad);
          }
          _isDragging = false;
      },
    );
  }
}

class MainHomeCardPlayer extends StatefulWidget {
  final PageController pageController;
  VideoPlayerController controller;
  Future<void> initializeVideoPlayerFuture;

  MainHomeCardPlayer(
    this.pageController,
    this.controller,
    this.initializeVideoPlayerFuture, { Key? key })
      : super(key: key);

  @override
  MainHomeCardPlayerState createState() => MainHomeCardPlayerState();
}

class MainHomeCardPlayerState extends State<MainHomeCardPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              constraints: BoxConstraints.expand(),
              color: Colors.black,
              // VideoPlayer의 종횡비를 제한하세요.
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Center(
                          child: AspectRatio(
                              aspectRatio: widget.controller.value.aspectRatio,
                              child: VideoPlayer(widget.controller)
                          )
                      ),
                      onTapDown: (_) {
                        setState(() {
                          // const snackBar = SnackBar(content: Text('Tap'));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          AppData.isShowPlayerInfo = !AppData.isShowPlayerInfo;
                        });
                      },
                  ),
                  VideoProgressIndicator(
                    widget.controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                        backgroundColor: Colors.grey,
                        bufferedColor: Colors.white,
                        playedColor: Colors.purple
                    ),
                  ),
                  AnimatedOpacity (
                    // If the widget is visible, animate to 0.0 (invisible).
                    // If the widget is hidden, animate to 1.0 (fully visible).
                    opacity: AppData.isShowPlayerInfo ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: IgnorePointer(
                      ignoring: !AppData.isShowPlayerInfo,
                      child: Row(
                        children: <Widget> [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: PlayerOverlayScreen(controller: widget.controller, onScreenClosed: (isShow) {
                                setState(() {
                                  AppData.isShowPlayerInfo = isShow;
                                });
                              })
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: UserOverlayScreen(onButtonSelect: (selectId) {
                                    setState(() {

                                    });
                                  })
                              )
                          ),
                        ]
                      )
                    )
                  )
                ],
              ),
            );
            // return VideoPlayer(_controller!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
