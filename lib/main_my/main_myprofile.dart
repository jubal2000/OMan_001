import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/screens/banner_scrollviewer.dart';
import 'package:oman_001/screens/category_viewer.dart';

class MainMyScreen extends StatefulWidget {
  const MainMyScreen({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainMyState();
}

class MainMyState extends State<MainMyScreen> with AutomaticKeepAliveClientMixin<MainMyScreen> {
  final List<MainMyTab> _tabList = [
    MainMyTab(0, "프로필"),
    MainMyTab(1, "나의쇼핑"),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppData.MainTheme,
        home: DefaultTabController(
          length: _tabList.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text("마이 페이지", style: AppData.MainTheme.textTheme.headline2),
              toolbarHeight: defaultTargetPlatform == TargetPlatform.android ? 0 : 50,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              bottom: TabBar(
                padding: EdgeInsets.symmetric(horizontal: 100),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.purple,
                tabs: _tabList.map((item) => item.getTab()).toList(),
              ),
            ),
            body: TabBarView(
              children: _tabList,
            ),
          ),
        )
    );
  }
}

class MainMyTab extends StatefulWidget {
  final int selectedTab;
  final String title;

  const MainMyTab(this.selectedTab, this.title, { Key? key })
      : super(key: key);

  Widget getTab() {
    return Tab(text: title, height: 40);
  }

  @override
  MainMyTabState createState() => MainMyTabState();
}

class MainMyTabState extends State<MainMyTab> with AutomaticKeepAliveClientMixin<MainMyTab> {
  final List<List<String>> _bannerList = [
    [
      "assets/sample/banner_00.png",
      "assets/sample/banner_01.png",
    ],[
      "assets/sample/banner_10.jpeg",
      "assets/sample/banner_11.jpeg",
      "assets/sample/banner_12.jpeg",
      "assets/sample/banner_13.jpeg",
    ]
  ];

  final List<String> _shareIcon = [
    "assets/ui/share_00.png",
    "assets/ui/share_01.png",
    "assets/ui/share_02.png",
  ];

  final List<MainMyTab> _tabList = [
    MainMyTab(0, "히스토리"),
    MainMyTab(1, "스토어"),
    MainMyTab(2, "포트폴리오"),
  ];

  final _msgTextController = TextEditingController();
  List<Widget> _shareLink = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _shareLink = _shareIcon.map((item) =>
        Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(item)
                )
            ),
        )).toList();
    _msgTextController.text =
      "할 말이 없을 때도 쓰기도 한다."
      "왜 하필 asdf인가 하면, QWERTY 자판 기준으로 키보드에 제일 먼저 왼손이 닿는 부위가 순서대로 A, S, D, F이기 때문이다.[1] 드보락 자판에서는 이 부분이 aoeu가 되며, 콜맥 자판에서는 arst가 된다. 비슷한 경우로 ㅁㄴㅇㄹ과 qwer 따위도 존재한다."
      "HTML에서 색상코드를 #asdf로 주면 이런 색상(■, 실제 코드 #A0DF00)으로 인식한다. 색상코드가 4자리로 주어진 경우 HTML에서는 앞 2자리를 R,";
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedTab) {
      case 0:{
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(0,5,0,0),
          child: Container(
            child: Column(
              children: [
                BannerScrollViewer(
                    _bannerList[0],
                    rowHeight: 150,
                    showArrow: true
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 20),
                      child: Column(
                        children : [
                          Container(
                            width: 120,
                            height: 120,
                              margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/sample/face_01.jpeg")
                              )
                            )
                          ),
                          Text("Lady35me@oman", style: AppData.MainTheme.textTheme.headline2),
                          Container(
                            width: 130,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: _shareLink,
                            ),
                          ),
                        ]
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 50),
                        child: Column(
                          children : [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("73.1K", style: AppData.MainTheme.textTheme.headline1),
                                    Text("팔로우", style: AppData.MainTheme.textTheme.bodyText2),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("2.2M", style: AppData.MainTheme.textTheme.headline1),
                                    Text("팔로워", style: AppData.MainTheme.textTheme.bodyText2),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("480", style: AppData.MainTheme.textTheme.headline1),
                                    Text("좋아요", style: AppData.MainTheme.textTheme.bodyText2),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextField(
                              readOnly: true,
                              controller: _msgTextController,
                              style: AppData.MainTheme.textTheme.bodyText1,
                              maxLines: 4,
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              // color: Colors.yellow,
                              child: IconButton(
                                onPressed: () {
                                },
                                icon: const Icon(Icons.drive_file_rename_outline, color: Colors.grey)
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                // DefaultTabController(
                //   length: _tabList.length,
                //   child: Scaffold(
                //     appBar: AppBar(
                //       title: Text("마이 페이지", style: AppData.MainTheme.textTheme.headline2),
                //       toolbarHeight: defaultTargetPlatform == TargetPlatform.android ? 0 : 50,
                //       backgroundColor: Colors.transparent,
                //       shadowColor: Colors.transparent,
                //       bottom: TabBar(
                //         padding: EdgeInsets.symmetric(horizontal: 120),
                //         labelColor: Colors.black,
                //         unselectedLabelColor: Colors.grey,
                //         indicatorColor: Colors.purple,
                //         tabs: _tabList.map((item) => item.getTab()).toList(),
                //       ),
                //     ),
                //     body: TabBarView(
                //       children: _tabList,
                //     ),
                //   ),
                // ),
              ]
            ),
          ),
        );
      }
      case 1: {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(0,5,0,0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                BannerScrollViewer(
                    _bannerList[1],
                    rowHeight: 250,
                    showArrow: false
                ),
                SizedBox(height: 10),
                Column(
                  children: AppData.goodsList,
                )
              ],
            ),
          ),
        );
      }
      default:{
        return Center();
      }
    }
  }
}

class MyProfileTab extends StatefulWidget {
  const MyProfileTab(this.selectedTab, this.title, { Key? key })
      : super(key: key);

  final int selectedTab;
  final String title;

  @override
  MyProfileTabState createState() => MyProfileTabState();
}

class MyProfileTabState extends State<MyProfileTab> {
  final List<String> _shareIcon = [
    "assets/ui/share_00.png",
    "assets/ui/share_01.png",
    "assets/ui/share_02.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}