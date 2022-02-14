import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/data/videos_firebase.dart';
import 'package:oman_001/screens/banner_scrollviewer.dart';
import 'package:oman_001/screens/category_viewer.dart';
import 'package:oman_001/widgets/goods_item_card.dart';

class MainStoreScreen extends StatefulWidget {
  MainStoreScreen({ Key? key }) : super(key: key);
  final _state = MainStoreState();

  void update(mode) {
    _state.update(mode);
  }

  @override
  State<StatefulWidget> createState() => _state;
}

class MainStoreState extends State<MainStoreScreen> with AutomaticKeepAliveClientMixin<MainStoreScreen> {
  final PageController _controller = PageController(viewportFraction: 1, keepPage: true);
  Future<List<GoodsItem>>? _calculation;

  final List<List<MainStoreTab>> _tabList = [[
      MainStoreTab(0, "홈"),
      MainStoreTab(1, "핫딜"),
      MainStoreTab(2, "주간베스트"),
      MainStoreTab(3, "신상품"),
    ],[
      MainStoreTab(10, "베스트"),
      MainStoreTab(11, "오늘의딜"),
      MainStoreTab(12, "새해맞이 특가"),
    ]];

  int _storeMode = 0;

  void update(mode) {
    _storeMode = mode;
    print("--> $mode");
    _controller.jumpToPage(mode);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (!AppData.isStoreDataReady) {
      _calculation = StoreListAPI().getAsyncLocalGoodsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _calculation,
        builder: (BuildContext context, AsyncSnapshot<List<GoodsItem>> snapshot) {
          print("--> MainStoreState : ${snapshot.hasData} / ${AppData.isStoreDataReady}");
          if (snapshot.hasData || AppData.isStoreDataReady) {
            if (!AppData.isStoreDataReady) {
              AppData.goodsList = snapshot.data!.map((item) => GoodsItemCard(item)).toList();
            }
            AppData.isStoreDataReady = true;

            return PageView.builder(
                controller: _controller,
                itemCount: _tabList.length,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                  // print("--> onPageChanged : $index");
                    _storeMode = index;
                  });
                },
                itemBuilder: (context, index) {
                  return DefaultTabController(
                    length: _tabList[index].length,
                    child: Scaffold(
                      appBar: AppBar(
                        toolbarHeight: defaultTargetPlatform == TargetPlatform.android ? 5 : 45,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        bottom: TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.purple,
                          labelPadding: EdgeInsets.all(0),
                          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                          tabs: _tabList[index].map((item) => item.getTab()).toList(),
                        ),
                      ),
                      body: TabBarView(
                        children: _tabList[index],
                      ),
                    ),
                  );
                }
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MainStoreTab extends StatefulWidget {
  final int selectedTab;
  final String title;

  const MainStoreTab(this.selectedTab, this.title, { Key? key })
      : super(key: key);

  Widget getTab() {
    return Tab(text: title, height: 40);
  }

  @override
  MainStoreTabState createState() => MainStoreTabState();
}

class MainStoreTabState extends State<MainStoreTab> with AutomaticKeepAliveClientMixin<MainStoreTab> {
  final List<List<String>> _bannerList = [
    [
      "assets/sample/banner_00.png",
      "assets/sample/banner_01.png",
      "assets/sample/banner_02.png",
      "assets/sample/banner_03.png",
    ],[
      "assets/sample/banner_10.jpeg",
      "assets/sample/banner_11.jpeg",
      "assets/sample/banner_12.jpeg",
      "assets/sample/banner_13.jpeg",
    ]
  ];

  final List<String> _cateTextList = [
    "디자인",
    "IT/프로그래밍",
    "영상/사진",
    "마케팅",
    "건강",
    "스포츠",
    "아트",
    "언어",
    "디자인",
    "IT/프로그래밍",
    "영상/사진",
    "마케팅",
    "건강",
    "스포츠",
    "아트",
    "언어",
  ];

  List<CategoryViewerItem>? _categoryItem;
  final _scrollController = PageController(viewportFraction: 1, keepPage: true);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _categoryItem = _cateTextList.map((item) => CategoryViewerItem(item)).toList();
    // _goodsItem = AppData.goodsList.map((item) => GoodsItemCard(item.imageUrl)).toList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
            color: Colors.white,
            child: Column(
              children: [
                BannerScrollViewer(
                  _bannerList[0],
                  rowHeight: 180,
                  showArrow: true
                ),
                CategoryViewer(
                  _categoryItem!,
                  title: "카테고리",
                  titleStyle: Theme.of(context).textTheme.headline2!
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
      case 10: {
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
                CategoryViewer(
                    _categoryItem!,
                    title: "카테고리",
                    titleStyle: Theme.of(context).textTheme.headline2!
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}