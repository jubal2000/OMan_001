import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oman_001/data/app_data.dart';

class MainSearchScreen extends StatelessWidget {
  final List<MainSearchTab> tabList = [
    MainSearchTab(0, "컨텐츠"),
    MainSearchTab(1, "태그"),
    MainSearchTab(2, "인물"),
    MainSearchTab(3, "장소"),
  ];

  MainSearchScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: defaultTargetPlatform == TargetPlatform.android ? 0 : 40,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
            bottom: TabBar(
              padding: EdgeInsets.symmetric(horizontal: 50),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.purple,
              tabs: tabList.map((item) => item.getTab()).toList(),
            ),
          ),
          body: TabBarView(
            children: tabList,
          ),
        ),
      );
  }
}

class MainSearchTab extends StatefulWidget {
  final int selectedTab;
  final String title;

  const MainSearchTab(this.selectedTab, this.title, { Key? key })
      : super(key: key);

  Widget getTab() {
    return Tab(text: title, height: 35);
  }

  @override
  MainSearchTabState createState() => MainSearchTabState();
}

class MainSearchTabState extends State<MainSearchTab> with AutomaticKeepAliveClientMixin<MainSearchTab> {
  final _controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
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
        return MasonryGridView.count(
          controller: _controller,
          itemCount: AppData.searchImageList.length,
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          itemBuilder: (BuildContext context, int index) {
            if (AppData.searchImageList[index].contains("http")) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  imageUrl: AppData.searchImageList[index],
                ),
              );
            } else {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(AppData.searchImageList[index]),
              );
            }
          }
        );
      }
      default:{
        return Center();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

