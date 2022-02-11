import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/screens/banner_scrollviewer.dart';
import 'package:oman_001/screens/goods_item_card.dart';
import 'package:oman_001/utils/utils.dart';

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
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MainTheme,
        home: DefaultTabController(
          length: _tabList.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text("마이 페이지", style: Theme.of(context).textTheme.headline2),
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

  final List<ListItemEx> _myMenuList = [
    ListItemEx("나의 쇼핑 정보", isTitle: true),
    ListItemEx("최근 본 상품"),
    ListItemEx("상품 리뷰 내역"),
    ListItemEx("주문배송내역 조회"),
    ListItemEx("배송지 관리", isLast: true),
  ];

  final _msgTextController = TextEditingController();
  final _scrollController = PageController(viewportFraction: 1, keepPage: true);

  var _tabviewHeight = 1600.0;

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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        _tabviewHeight = AppData.myProfileTabViewHeight;
        print("--> $_tabviewHeight");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedTab) {
      case 0:{
        return SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(0,5,0,0),
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
                          Text("Lady35me@oman", style: Theme.of(context).textTheme.headline2),
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
                                    Text("73.1K", style: Theme.of(context).textTheme.headline1),
                                    Text("팔로우", style: Theme.of(context).textTheme.bodyText2),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("2.2M", style: Theme.of(context).textTheme.headline1),
                                    Text("팔로워", style: Theme.of(context).textTheme.bodyText2),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("480", style: Theme.of(context).textTheme.headline1),
                                    Text("좋아요", style: Theme.of(context).textTheme.bodyText2),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextField(
                              readOnly: true,
                              controller: _msgTextController,
                              style: Theme.of(context).textTheme.bodyText1,
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
                DefaultTabController(
                    length: _tabList.length,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: TabBar(
                            onTap: (index) {
                              setState(() {
                                _currentTab = index;
                              });
                            },
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.purple,
                            tabs: _tabList.map((item) => item.getTab()).toList(),
                          ),
                        ),
                        SizedBox(
                          height: _tabviewHeight,
                          child: TabBarView(
                            children: _tabList,
                          ),
                        ),
                      ],
                    ),
                  ),
              ]
            ),
        );
      }
      case 1: {
        return SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 1,
                color: Colors.grey.withOpacity(0.3),
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShoppingTopItem("assets/ui/my_coupon_00.png", "내 쿠폰", Colors.orange.withOpacity(0.5)),
                  ShoppingTopItem("assets/ui/my_likes_00.png", "찜", Colors.pinkAccent.withOpacity(0.5)),
                  ShoppingTopItem("assets/ui/my_rank_00.png", "등급", Colors.deepPurpleAccent.withOpacity(0.5)),
                ]
              ),
              SizedBox(height: 30),
              ListView.builder(
                  shrinkWrap: true, // use this
                  scrollDirection: Axis.vertical,
                  itemCount: _myMenuList.length,
                  itemBuilder : (BuildContext context, int index) => _myMenuList[index]
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              //   child: Text("나의 쇼핑 정보", style: AppData.MainTheme.textTheme.headline1),
              // ),
              // SizedBox(height: 10),
              // ShoppingMidItem("최근 본 상품"),
              // ShoppingMidItem("상품 리뷰 내역"),
              // ShoppingMidItem("주문배송내역 조회"),
              // ShoppingMidItem("배송지 관리"),
              Container(
                height: 50,
                color: Colors.grey.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("진행중인 주문", style: Theme.of(context).textTheme.headline1),
                    SizedBox(width: 5),
                    Text("(최근 3개월)", style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShoppingBotItem("입금\n대기", 1),
                    botArrow,
                    ShoppingBotItem("결제\n완료", 0),
                    botArrow,
                    ShoppingBotItem("배송\n준비", 2),
                    botArrow,
                    ShoppingBotItem("배송\n중", 1),
                    botArrow,
                    ShoppingBotItem("배송\n완료", 1),
                    botArrow,
                    ShoppingBotItem("리뷰\n쓰기", 0),
                  ],
                ),
              ),
            ],
          ),
        );
      }
      default:{
        return Center();
      }
    }
  }

  Widget get botArrow {
    return Container(
      height: 80,
      padding: EdgeInsets.only(top: 15),
      alignment: Alignment.topCenter,
      child: Image.asset("assets/ui/my_arrow_00.png", width: 15, height: 30, color: Colors.purple),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class ShoppingTopItem extends StatelessWidget {
  ShoppingTopItem(this.iconUrl, this.title, this.backgroundColor, {Key? key}) : super(key: key);

  String iconUrl;
  String title;
  Color  backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 110,
          height: 110,
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                child: Image.asset(iconUrl),
                padding: EdgeInsets.all(10),
              ),
              Text(title, style: TextStyle(fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold)),
            ]
        ),
      ),
    );
  }
}

class ShoppingBotItem extends StatelessWidget {
  ShoppingBotItem(this.title, this.count, {Key? key}) : super(key: key);

  String title;
  int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 35,
      // color: Colors.grey.withOpacity(0.25),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black)),
          SizedBox(height: 5),
          Text("$count", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.purple)),
        ]
      ),
    );
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
  final List<String> _imageList = [
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
    GoodsItem("0", 1, "01", "01", title: "1.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/1.jpeg", ribbon: "신상품", price: 10000.0, priceOrg: 15000.0, saleRatio: 33.3, likes: 224, comments: 123),
    GoodsItem("1", 1, "01", "01", title: "2.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/2.jpeg", ribbon: "인기", price: 11700.0, priceOrg: 13000.0, saleRatio: 10.0, likes: 19, comments: 23),
    GoodsItem("2", 1, "01", "01", title: "3.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/3.jpeg", ribbon: "", price: 20000.0, priceOrg: 25000.0, saleRatio: 20.0, likes: 24, comments: 11),
    GoodsItem("3", 1, "01", "01", title: "4.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/4.jpeg", ribbon: "", price: 18000.0, priceOrg: 25000.0, saleRatio: 10.0, likes: 4, comments: 43),
    GoodsItem("4", 1, "01", "01", title: "5.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/5.jpeg", ribbon: "", price: 13000.0, priceOrg: 15000.0, saleRatio: 10.0, likes: 16, comments: 83),
    GoodsItem("5", 1, "01", "01", title: "6.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/6.jpeg", ribbon: "", price: 8000.0, priceOrg: 10000.0, saleRatio: 5.0, likes: 124, comments: 132),
    GoodsItem("6", 1, "01", "01", title: "7.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/7.jpeg", ribbon: "", price: 18000.0, priceOrg: 25000.0, saleRatio: 10.0, likes: 4, comments: 43),
    GoodsItem("7", 1, "01", "01", title: "8.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/8.jpeg", ribbon: "", price: 13000.0, priceOrg: 15000.0, saleRatio: 10.0, likes: 16, comments: 83),
    GoodsItem("8", 1, "01", "01", title: "9.새로운 상품을 소개합니다!!", desc: "핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!핫한 새로운 상품을 소개합니다!! 내용이 들어갑니다!", imageUrl: "assets/sample/9.jpeg", ribbon: "", price: 8000.0, priceOrg: 10000.0, saleRatio: 5.0, likes: 124, comments: 132),
  ];

  final _tabController1 = PageController(viewportFraction: 1, keepPage: true);
  final _tabController2 = PageController(viewportFraction: 1, keepPage: true);
  final _edgeInsets = EdgeInsets.fromLTRB(20, 10, 20, 20);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedTab) {
      case 0:{
        var axisMax = 3;
        var axisSpacing = 10.0;
        var itemHeight = MediaQuery.of(context).size.width / axisMax;
        var itemCount = _imageList.length / axisMax;
        AppData.myProfileTabViewHeight = itemHeight * itemCount - (axisSpacing * (itemCount - 1)) + _edgeInsets.top + _edgeInsets.bottom + 30;
        return GridView.builder(
            controller: _tabController1,
            itemCount: _imageList.length,
            physics: NeverScrollableScrollPhysics(),
            padding: _edgeInsets,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: axisMax, //1 개의 행에 보여줄 item 개수
              mainAxisSpacing: axisSpacing, //수평 Padding
              crossAxisSpacing: axisSpacing, //수직 Padding
            ),
            itemBuilder: (BuildContext context, int index) =>
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                  color: Colors.grey.withOpacity(0.1),
                    child: Image.asset(_imageList[index]),
                  )
                )
        );
      //   return MasonryGridView.count(
      //     controller: _tabController1,
      //     itemCount: imageList.length,
      //     crossAxisCount: 3,
      //     mainAxisSpacing: 2,
      //     crossAxisSpacing: 2,
      //     padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      //     itemBuilder: (BuildContext context, int index) {
      //       return Card(
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(8.0),
      //             child: Image.asset(imageList[index]),
      //           )
      //       );
      //     }
      //   );
      }
      case 2: {
        var axisMax = 2;
        var axisSpacing = 10.0;
        var itemHeight = MediaQuery.of(context).size.width / axisMax;
        var itemCount = _imageList.length / axisMax;
        AppData.myProfileTabViewHeight = itemHeight * itemCount - (axisSpacing * (itemCount - 1)) + _edgeInsets.top + _edgeInsets.bottom + 30;
        return GridView.builder(
            controller: _tabController2,
            itemCount: _goodsList.length,
            physics: NeverScrollableScrollPhysics(),
            padding: _edgeInsets,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: axisMax, //1 개의 행에 보여줄 item 개수
              mainAxisSpacing: axisSpacing, //수평 Padding
              crossAxisSpacing: axisSpacing, //수직 Padding
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

  @override
  void dispose() {
    _tabController1.dispose();
    _tabController2.dispose();
    super.dispose();
  }
}