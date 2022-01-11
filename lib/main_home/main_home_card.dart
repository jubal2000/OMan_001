import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/cupertino.dart';
import 'package:oman_001/data/user_item.dart';
import 'package:oman_001/main_home/player_overlay.dart';
import 'package:oman_001/main_home/user_overlay.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class MainHomeCard extends StatefulWidget {
  final UserItem user;
  final String historyId;
  final Map<String, HomeVideoItem> _itemList = {};
  final List<String> _itemIdList = [];

  MainHomeCard(this.user, this.historyId, {Key? key}) : super(key: key) {
    for (var item in user.historyData) {
      var control = VideoPlayerController.network(item.url!);
      var initialize = control.initialize();
      _itemList[item.id!] = HomeVideoItem(control, initialize);
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

class HomeVideoItem {
  VideoPlayerController controller;
  Future<void> initializeVideoPlayerFuture;
  HomeVideoItem (
      this.controller,
      this.initializeVideoPlayerFuture
      );
}

class MainHomeCardState extends State<MainHomeCard> {
  PageController pageController = PageController(viewportFraction: 1, keepPage: true);
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
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget._itemList.length,
        onPageChanged: (index) {
          print("--> page changed : $index / $_itemIndexOrg");
          widget._itemList[index]?.controller.play();
          if (_itemIndexOrg >= 0) {
            widget._itemList[_itemIndexOrg]?.controller.pause();
          }
          _itemIndexOrg = index;
        },
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var itemId = widget._itemIdList[index];
          widget._itemList[index]?.controller.play();
          return MainHomeCardPlayer(itemInfo: widget._itemList[itemId]!, controller: pageController);
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
            pageController.animateToPage(pageController.page!.toInt()-1, duration: Duration(milliseconds: 250), curve: Curves.easeInQuad);
          } else {
            pageController.animateToPage(pageController.page!.toInt()+1, duration: Duration(milliseconds: 250), curve: Curves.easeInQuad);
          }
          _isDragging = false;
      },
    );
  }
}

class MainHomeCardPlayer extends StatefulWidget {
  final HomeVideoItem itemInfo;
  final PageController controller;

  const MainHomeCardPlayer({ Key? key,
    required this.itemInfo,
    required this.controller})
      : super(key: key);

  @override
  MainHomeCardPlayerState createState() => MainHomeCardPlayerState();
}

class MainHomeCardPlayerState extends State<MainHomeCardPlayer> {
  var _showPlayer = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.itemInfo.initializeVideoPlayerFuture,
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
                              aspectRatio: widget.itemInfo.controller.value.aspectRatio,
                              child: VideoPlayer(widget.itemInfo.controller)
                          )
                      ),
                      onTapDown: (_) {
                        setState(() {
                          // const snackBar = SnackBar(content: Text('Tap'));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _showPlayer = !_showPlayer;
                        });
                      },
                  ),
                  VideoProgressIndicator(
                    widget.itemInfo.controller,
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
                    opacity: _showPlayer ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: IgnorePointer(
                      ignoring: !_showPlayer,
                      child: Row(
                        children: <Widget> [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: PlayerOverlayScreen(controller: widget.itemInfo.controller, onScreenClosed: (isShow) {
                                setState(() {
                                  _showPlayer = isShow;
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
