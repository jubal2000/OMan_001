import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oman_001/data/home_item.dart';
import 'package:oman_001/data/videos_firebase.dart';
import 'package:oman_001/main_home/main_home_card.dart';
import 'package:oman_001/screens/feed_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({ Key? key })
      : super(key: key);

  @override
  MainHomeState createState() => MainHomeState();
}

class MainHomeState extends State<MainHomeScreen> {
  final locator = GetIt.instance;
  final feedViewModel = GetIt.instance<FeedViewModel>();

  List<MainHomeCard>? _homeList;
  var mainList = MainListAPI().load();

  @override
  void initState() {
    for (var item in mainList) {
      _homeList!.add(MainHomeCard(user: item.user, historyId: item.historyId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        disposeViewModel: false,
        builder: (context, model, child) => videoScreen(),
        viewModelBuilder: () => feedViewModel);
  }

  Widget videoScreen() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: _homeList!.length,
          onPageChanged: (index) {
            index = index % _homeList!.length;
            _homeList![index].play();
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % _homeList!.length;
            return _homeList![index];
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
      ],
    );
  }
}