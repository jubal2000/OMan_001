import 'package:flutter/services.dart';
import 'package:oman_001/data/videos_firebase.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FeedViewModel extends BaseViewModel {
  VideoPlayerController? controller;
  MainListAPI? videoSource;

  int prevVideo = 0;
  int actualScreen = 0;

  FeedViewModel() {
    videoSource = MainListAPI();
  }

  changeVideo(index) async {
    // if (videoSource!.listData[index].controller == null) {
    //   await videoSource!.listData[index].loadController();
    // }
    // videoSource!.listData[index].controller!.play();
    // //videoSource.listVideos[prevVideo].controller.removeListener(() {});
    //
    // if (videoSource!.listData[prevVideo].controller != null)
    //   videoSource!.listData[prevVideo].controller!.pause();

    prevVideo = index;
    notifyListeners();

    print(index);
  }

  void loadVideo(int index) async {
    // if (videoSource!.listData.length > index) {
    //   await videoSource!.listData[index].loadController();
    //   videoSource!.listData[index].controller?.play();
    //   notifyListeners();
    // }
  }

  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
