import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/screens/banner_scrollviewer.dart';
import 'package:oman_001/screens/row_scrollviewer.dart';

class MainOmanScreen extends StatefulWidget {
  MainOmanScreen({ Key? key }) : super(key: key);

  @override
  MainOmanState createState() => MainOmanState();
}

class MainOmanState extends State<MainOmanScreen> with AutomaticKeepAliveClientMixin<MainOmanScreen> {
  final List<String> _bannerList = [
    "assets/sample/21.jpeg",
    "assets/sample/22.jpeg",
    "assets/sample/23.jpeg",
    "assets/sample/24.jpeg",
    "assets/sample/25.jpeg",
  ];

  final List<String> _modelList = [
    "assets/sample/31.jpeg",
    "assets/sample/32.jpeg",
    "assets/sample/33.jpeg",
    "assets/sample/34.jpeg",
    "assets/sample/35.jpeg",
  ];

  final List<String> _newbieList = [
    "assets/sample/35.jpeg",
    "assets/sample/34.jpeg",
    "assets/sample/36.jpeg",
    "assets/sample/32.jpeg",
    "assets/sample/33.jpeg",
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppData.MainTheme,
        home: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  BannerScrollViewer(
                      _bannerList,
                      title: "투데이핫이슈",
                      titleStyle: AppData.MainTheme.textTheme.headline2!,
                      showArrow: true
                  ),
                  RowScrollViewer(
                     title: "# 최근 뜨는 모델",
                     itemList: _modelList,
                  ),
                  RowScrollViewer(
                    title: "# 최근 데뷰했어요",
                    itemList: _newbieList,
                  ),
                ],
              ),
            ),
        )
    );
  }
}