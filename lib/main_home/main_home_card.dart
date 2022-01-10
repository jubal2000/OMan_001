import 'package:flutter/material.dart';
import 'package:oman_001/data/user_item.dart';
import 'package:oman_001/main_home/player_overlay.dart';
import 'package:oman_001/main_home/user_overlay.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class MainHomeCard extends StatefulWidget {
  final UserItem user;
  final String historyId;

  const MainHomeCard(this.user, this.historyId, {Key? key}) : super(key: key);

  play() {
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
  Map<String, HomeVideoItem>? _itemList;
  final List<String> _itemIdList = [];

  @override
  void initState() {
    print("--> initState : ${widget.user.historyData}");
    for (var item in widget.user.historyData) {
      var control = VideoPlayerController.network(item.url!);
      var initialize = control.initialize();
      _itemList![item.id!] = HomeVideoItem(control, initialize);
      _itemIdList.add(item.id!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        initialPage: 0,
        viewportFraction: 1,
      ),
      itemCount: _itemList?.length,
      onPageChanged: (index) {
        _itemList?[index]!.controller.play();
      },
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var itemId = _itemIdList[index];
        return MainHomeCardPlayer(itemInfo: _itemList![itemId]!);
      },
    );
  }
}

class MainHomeCardPlayer extends StatefulWidget {
  final HomeVideoItem itemInfo;

  const MainHomeCardPlayer({ Key? key,
    required this.itemInfo})
      : super(key: key);

  @override
  MainHomeCardPlayerState createState() => MainHomeCardPlayerState();
}

class MainHomeCardPlayerState extends State<MainHomeCardPlayer> {
  late HomeVideoItem itemInfo;
  var _showPlayer = true;

  @override
  void initState() {
    itemInfo = widget.itemInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: itemInfo.initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
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
                              aspectRatio: itemInfo.controller.value.aspectRatio,
                              child: VideoPlayer(itemInfo.controller)
                          )
                      ),
                      onTapDown: (_) {
                        setState(() {
                          // const snackBar = SnackBar(content: Text('Tap'));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _showPlayer = !_showPlayer;
                        });
                      }
                  ),
                  VideoProgressIndicator(
                    itemInfo.controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                        backgroundColor: Colors.white,
                        bufferedColor: Colors.yellow,
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
                                    child: PlayerOverlayScreen(controller: itemInfo.controller, onScreenClosed: (isShow) {
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
