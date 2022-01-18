import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
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
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
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
      default:{
        return Center();
      }
    }
  }
}

