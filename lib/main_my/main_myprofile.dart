import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/screens/banner_scrollviewer.dart';
import 'package:oman_001/screens/category_viewer.dart';
import 'package:oman_001/screens/goods_item_card.dart';

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
  var _currentTab = 0;

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
                onTap: (index) {
                  setState(() {
                    _currentTab = index;
                  });
                },
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

  final List<MyProfileTab> _tabList = [
    MyProfileTab(0, "히스토리"),
    MyProfileTab(1, "포트폴리오"),
    MyProfileTab(2, "스토어"),
  ];

  final _msgTextController = TextEditingController();
  final _scrollController = PageController(viewportFraction: 1, keepPage: true);

  List<Widget> _shareLink = [];
  var _currentTab = 0;

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
          controller: _scrollController,
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
                            SizedBox(height: 10),
                            TextField(
                              readOnly: true,
                              controller: _msgTextController,
                              style: AppData.MainTheme.textTheme.bodyText1,
                              maxLines: 5,
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {

                                },
                                child: const Icon(Icons.drive_file_rename_outline, color: Colors.grey)
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  // color: Colors.green,
                  child: DefaultTabController(
                    length: _tabList.length,
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: TabBar(
                            onTap: (index) {
                              setState(() {
                                _currentTab = index;
                              });
                            },
                            padding: EdgeInsets.symmetric(horizontal: 100),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.purple,
                            tabs: _tabList.map((item) => item.getTab()).toList(),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                            children: _tabList,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 30),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           IconButton(
                //               onPressed:() {
                //                 setState(() {
                //                   _currentTab = 0;
                //                 });
                //               },
                //               icon: const Icon(Icons.border_all, color: Colors.grey)
                //           ),
                //           IconButton(
                //               onPressed:() {
                //                 setState(() {
                //                   _currentTab = 1;
                //                 });
                //               },
                //               icon: const Icon(Icons.folder_open, color: Colors.grey)
                //           ),
                //           IconButton(
                //               onPressed:() {
                //                 setState(() {
                //                   _currentTab = 2;
                //                 });
                //               },
                //               icon: const Icon(Icons.store, color: Colors.grey)
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: 10),
                //       // Container(
                //       //   child: PageView.builder(
                //       //     controller: _tabController,
                //       //     itemCount: _tabList.length,
                //       //     onPageChanged: (index) {
                //       //
                //       //     },
                //       //     itemBuilder: (context, index) {
                //       //       return _tabList[index];
                //       //     },
                //       //   )
                //       // ),
                //     ]
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

  Widget getTab() {
    return Tab(text: title, height: 40);
  }

  @override
  MyProfileTabState createState() => MyProfileTabState();
}

class MyProfileTabState extends State<MyProfileTab> {
  List<String> imageList = [
    'assets/sample/1.jpeg',
    'assets/sample/2.jpeg',
    'assets/sample/3.jpeg',
    'assets/sample/4.jpeg',
    'assets/sample/5.jpeg',
    'assets/sample/6.jpeg',
    'assets/sample/7.jpeg',
    'assets/sample/8.jpeg',
    'assets/sample/9.jpeg',
    'assets/sample/10.jpeg',
    'assets/sample/1.jpeg',
    'assets/sample/2.jpeg',
    'assets/sample/3.jpeg',
    'assets/sample/4.jpeg',
    'assets/sample/5.jpeg',
    'assets/sample/6.jpeg',
    'assets/sample/7.jpeg',
    'assets/sample/8.jpeg',
    'assets/sample/9.jpeg',
    'assets/sample/10.jpeg',
  ];
  
  final List<GoodsItem> _goodsList = [
    GoodsItem(id: "0", title: "1.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/1.jpeg", ribbon: "신상품", price: 10000.0, priceOrg: 15000.0, saleRatio: 33.3, likes: 224, comments: 123),
    GoodsItem(id: "1", title: "2.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/2.jpeg", ribbon: "인기", price: 11700.0, priceOrg: 13000.0, saleRatio: 10.0, likes: 19, comments: 23),
    GoodsItem(id: "2", title: "3.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/3.jpeg", ribbon: "", price: 20000.0, priceOrg: 25000.0, saleRatio: 20.0, likes: 24, comments: 11),
    GoodsItem(id: "3", title: "4.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/4.jpeg", ribbon: "", price: 18000.0, priceOrg: 25000.0, saleRatio: 10.0, likes: 4, comments: 43),
    GoodsItem(id: "4", title: "5.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/5.jpeg", ribbon: "", price: 13000.0, priceOrg: 15000.0, saleRatio: 10.0, likes: 16, comments: 83),
    GoodsItem(id: "5", title: "6.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/6.jpeg", ribbon: "", price: 8000.0, priceOrg: 10000.0, saleRatio: 5.0, likes: 124, comments: 132),
    GoodsItem(id: "6", title: "7.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/7.jpeg", ribbon: "", price: 18000.0, priceOrg: 25000.0, saleRatio: 10.0, likes: 4, comments: 43),
    GoodsItem(id: "7", title: "8.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/8.jpeg", ribbon: "", price: 13000.0, priceOrg: 15000.0, saleRatio: 10.0, likes: 16, comments: 83),
    GoodsItem(id: "8", title: "9.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/9.jpeg", ribbon: "", price: 8000.0, priceOrg: 10000.0, saleRatio: 5.0, likes: 124, comments: 132),
  ];

  final _gridbarController = PageController(viewportFraction: 1, keepPage: true);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // caching images..
    for (var item in imageList) {
      precacheImage(AssetImage(item), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedTab) {
      case 0:{
        return MasonryGridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: imageList.length,
          itemBuilder: (BuildContext context, int index) =>
              Card(
                // child: FittedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(imageList[index]),
                  )
                // child: Image.network(imageList[index]),
                //   fit: BoxFit.fill,
                // ),
              ),
        );
      }
      case 2: {
        return GridView.builder(
            controller: _gridbarController,
            itemCount: _goodsList.length,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 1, //item 의 가로 1, 세로 2 의 비율
              mainAxisSpacing: 10, //수평 Padding
              crossAxisSpacing: 10, //수직 Padding
            ),
            itemBuilder: (BuildContext context, int index) =>
                GoodsItemSquareCard(_goodsList[index], sellType: GoodsItemCardSellType.goods, backgroundColor: Colors.grey.withOpacity(0.1))
        );
      }
      default:{
        return Center();
      }
    }
  }
}