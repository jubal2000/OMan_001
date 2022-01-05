import 'package:flutter/material.dart';
import 'package:oman_001/main_home/player_modal.dart';
import 'package:oman_001/main_home/player_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class MainHomeScreen extends StatefulWidget {
  final BuildContext? menuScreenContext;
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;

  const MainHomeScreen({ Key? key,
    this.menuScreenContext,
    this.onScreenHideButtonPressed,
    this.hideStatus = false})
      : super(key: key);

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<MainHomeScreen> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  bool _showPlayer = true;

  @override
  void initState() {
    // VideoPlayerController를 저장하기 위한 변수를 만듭니다. VideoPlayerController는
    // asset, 파일, 인터넷 등의 영상들을 제어하기 위해 다양한 생성자를 제공합니다.
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _initializeVideoPlayerFuture = _controller!.initialize();
    // _rootContext = widget.menuScreenContext;
    super.initState();
  }

  @override
  void dispose() {
    // 자원을 반환하기 위해 VideoPlayerController를 dispose 시키세요.
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Butterfly Video'),
      // ),
      // VideoPlayerController가 초기화를 진행하는 동안 로딩 스피너를 보여주기 위해
      // FutureBuilder를 사용합니다.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
            return Container(
              constraints: BoxConstraints.expand(),
              color: Colors.black,
              // VideoPlayer의 종횡비를 제한하세요.
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: VideoPlayer(_controller!),
                      onTapDown: (_) {
                        setState(() {
                          // const snackBar = SnackBar(content: Text('Tap'));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _showPlayer = !_showPlayer;
                          print("--> showPlayer : $_showPlayer");
                          // showPlayer ? pushDynamicScreen(context, screen: _playerModalScreen, withNavBar: true)
                          //           : _playerModalScreen.close();

                          // showModalBottomSheet(
                          //     context: context,
                          //     backgroundColor: Colors.white,
                          //     useRootNavigator: false,
                          //     builder: (context) =>
                          //         Center(
                          //             child: ElevatedButton(
                          //               onPressed: () {
                          //                 Navigator.pop(context);
                          //               },
                          //               child: Text(
                          //                 "Exit",
                          //                 style: TextStyle(color: Colors.white),
                          //               ),
                          //             )
                          //         )
                          //   );
                          });
                        }
                    ),
                    VideoProgressIndicator(
                      _controller!,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                          backgroundColor: Colors.white,
                          bufferedColor: Colors.yellow,
                          playedColor: Colors.purple
                      ),
                    ),
                    Visibility(
                      visible: _showPlayer,
                      child: PlayerOverlayScreen(_controller, () {
                        setState(() {
                          _showPlayer = false;
                        });
                      })
                    )
                  ],
                ),
              ),
            );
          // return VideoPlayer(_controller!);
          } else {
            // 만약 VideoPlayerController가 여전히 초기화 중이라면,
            // 로딩 스피너를 보여줍니다.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
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
        // 플레이어의 상태에 따라 올바른 아이콘을 보여줍니다.
        child: Icon(
          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // 이 마지막 콤마는 build 메서드에 자동 서식이 잘 적용될 수 있도록 도와줍니다.
    );
  }
}

  //   return SingleChildScrollView(
  //     child: SizedBox(
  //       height: MediaQuery.of(context).size.height,
  //       width: MediaQuery.of(context).size.width,
  //       child: Scaffold(
  //         backgroundColor: Colors.indigo,
  //         body: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.symmetric(
  //                   horizontal: 30.0, vertical: 20.0),
  //               child: TextField(
  //                 decoration: InputDecoration(hintText: "Test Text Field"),
  //               ),
  //             ),
  //             Center(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   pushNewScreenWithRouteSettings(
  //                     context,
  //                     settings: RouteSettings(name: '/home'),
  //                     screen: MainSearchScreen(),
  //                     pageTransitionAnimation:
  //                     PageTransitionAnimation.scaleRotate,
  //                   );
  //                 },
  //                 child: Text(
  //                   "Go to Second Screen ->",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             Center(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   showModalBottomSheet(
  //                     context: context,
  //                     backgroundColor: Colors.white,
  //                     useRootNavigator: true,
  //                     builder: (context) => Center(
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: Text(
  //                           "Exit",
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 child: Text(
  //                   "Push bottom sheet on TOP of Nav Bar",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             Center(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   showModalBottomSheet(
  //                     context: context,
  //                     backgroundColor: Colors.white,
  //                     useRootNavigator: false,
  //                     builder: (context) => Center(
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: Text(
  //                           "Exit",
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 child: Text(
  //                   "Push bottom sheet BEHIND the Nav Bar",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             Center(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   pushDynamicScreen(context,
  //                       screen: SampleModalScreen(), withNavBar: true);
  //                 },
  //                 child: Text(
  //                   "Push Dynamic/Modal Screen",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             Center(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   onScreenHideButtonPressed!();
  //                 },
  //                 child: Text(
  //                   hideStatus
  //                       ? "Unhide Navigation Bar"
  //                       : "Hide Navigation Bar",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             Center(
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(menuScreenContext!).pop();
  //                 },
  //                 child: Text(
  //                   "<- Main Menu",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 60.0,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
// }
