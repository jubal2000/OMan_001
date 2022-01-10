import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
  final Future<List<HomeItem>> _calculation = MainListAPI().getLocalHomeList();
  // final feedViewModel = GetIt.instance<FeedViewModel>();

  final List<MainHomeCard> _homeList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _calculation,
        builder: (BuildContext context, AsyncSnapshot<List<HomeItem>> snapshot) {
          if (snapshot.hasData) {
            for (var item in snapshot.data!) {
              _homeList.add(MainHomeCard(item.user!, item.historyId!));
            }
            return Stack(
              children: [
                PageView.builder(
                  controller: PageController(
                    initialPage: 0,
                    viewportFraction: 1,
                  ),
                  itemCount: _homeList.length,
                  onPageChanged: (index) {
                    print("--> onPageChanged : $index");
                    index = index % _homeList.length;
                    _homeList[index].play();
                  },
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    index = index % _homeList.length;
                    print("--> itemBuilder : $index / ${_homeList.length}");
                    return MainHomeCard(_homeList[index].user, _homeList[index].historyId);
                  },
                ),
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Following',
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
                          Text('For You',
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
}