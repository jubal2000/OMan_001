import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/home_item.dart';
import 'package:oman_001/data/videos_firebase.dart';
import 'package:oman_001/main_home/main_home_card.dart';
import 'package:oman_001/screens/feed_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({ Key? key })
      : super(key: key);

  @override
  MainHomeState createState() => MainHomeState();
}

class MainHomeState extends State<MainHomeScreen> {
  final locator = GetIt.instance;
  final PageController controller = PageController(viewportFraction: 1, keepPage: true);
  Future<List<HomeItem>>? _calculation;
  final List<MainHomeCard> _homeList = [];

  var _startPos = Offset(0, 0);
  var _isDragging = false;
  var _orgPageIndex = -1;

  @override
  void initState() {
    super.initState();
    if (!AppData.isMainDataReady) {
      _calculation = MainListAPI().getLocalHomeList();
    }
    controller.addListener(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _calculation,
      builder: (BuildContext context, AsyncSnapshot<List<HomeItem>> snapshot) {
        if (snapshot.hasData) {
          if (!AppData.isMainDataReady) {
            _homeList.clear();
            for (var item in snapshot.data!) {
              _homeList.add(MainHomeCard(item.user!, item.historyId!));
            }
            AppData.isMainDataReady = true;
          }
          return Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemCount: _homeList.length,
                onPageChanged: (index) {
                  print("--> onPageChanged : $index");
                  index = index % _homeList.length;
                  for (var i=0; i<snapshot.data!.length; i++) {
                    if (i == index) {
                      _homeList[index].play();
                    } else if (_orgPageIndex >= 0) {
                      _homeList[_orgPageIndex].stop();
                    }
                  }
                  _orgPageIndex = index;
                },
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  index = index % _homeList.length;
                  print("--> itemBuilder : $index / ${_homeList.length}");
                  return GestureDetector(
                      // child: MainHomeCard(_homeList[index].user, _homeList[index].historyId),
                    child: _homeList[index],
                      onVerticalDragStart: (pos) {
                        _startPos = pos.localPosition;
                        _isDragging = true;
                      },
                      onVerticalDragUpdate: (pos) {
                        if (!_isDragging) return;
                        // print("--> page : ${controller.page!.toInt()} / ${_startPos.dx} < ${pos.localPosition.dx}");
                        if (_startPos.dy < pos.localPosition.dy) {
                          controller.animateToPage(controller.page!.toInt()-1, duration: Duration(milliseconds: AppData().SCROLL_SPEED), curve: Curves.easeInQuad);
                        } else {
                          controller.animateToPage(controller.page!.toInt()+1, duration: Duration(milliseconds: AppData().SCROLL_SPEED), curve: Curves.easeInQuad);
                        }
                        _isDragging = false;
                      },
                  );
                },
              ),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Test',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white70)),
                      SizedBox(
                        width: 7,
                      ),
                      Container(
                        color: Colors.white70,
                        height: 10,
                        width: 1.0,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text('Movie',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ]),
                  ),
                ),
              ]
            );
          } else {
            return Center(
              child: Text(
                "Loading..."
              )
            );
          }
        }
     );
    }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
}