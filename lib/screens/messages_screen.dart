import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/utils/tik_tok_icons_icons.dart';
import 'package:oman_001/widgets/search_widget.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({Key? key}) : super(key: key);

  final List<MessagesTab> _tabList = [
    MessagesTab(0, "모든채팅"),
    MessagesTab(1, "팔로우"),
  ];

  var _currentTab = 0;

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(defaultTargetPlatform == TargetPlatform.android ? 20 : 50), // here the desired height
          child: AppBar(
            title: Text('채팅', style: AppData.MainTheme.textTheme.headline1),
            titleSpacing: 0,
            elevation: 1,
            primary: false,
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey,
          ),
        ),
      body: DefaultTabController(
        length: widget._tabList.length,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            bottom: TabBar(
              padding: EdgeInsets.symmetric(horizontal: 50),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.purple,
              tabs: widget._tabList.map((item) => item.getTab()).toList(),
            ),
          ),
          body: TabBarView(
            children: widget._tabList,
          ),
        ),
      ),
    );
  }
}

class MessagesTab extends StatefulWidget {
  MessagesTab(this.selectedTab, this.title, { Key? key }) : super(key: key);

  final int selectedTab;
  final String title;

  final List<MessageItemGroup> _itemList = [
    MessageItemGroup("assets/sample/face_10.jpeg", "테스터 1", "1.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_11.jpeg", "테스터 2", "2.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_12.jpeg", "테스터 3", "3.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_13.jpeg", "테스터 4", "4.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_14.jpeg", "테스터 5", "5.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_15.jpeg", "테스터 6", "6.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_10.jpeg", "테스터 1", "1.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_11.jpeg", "테스터 2", "2.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_12.jpeg", "테스터 3", "3.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_13.jpeg", "테스터 4", "4.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_14.jpeg", "테스터 5", "5.테스트 메시지입니다...", DateTime.now()),
    MessageItemGroup("assets/sample/face_15.jpeg", "테스터 6", "6.테스트 메시지입니다...", DateTime.now()),
  ];

  Widget getTab() {
    return Tab(text: title, height: 40);
  }

  @override
  MessagesTabState createState() => MessagesTabState();
}

class MessagesTabState extends State<MessagesTab> {
  final _scrollController = PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedTab) {
      case 0: {
        return Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Column(
            children: [
              SearchWidget(key: AppData.searchWidgetKey),
              Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  itemCount: widget._itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widget._itemList[index];
                  }
                ),
              ),
            ]
          )
        );
      }
      default: {
        return Container();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class MessageItemGroup extends StatefulWidget {
  MessageItemGroup(this.imageUrl, this.userName, this.message, this.lastTime, {Key? key, this.messageCount = 0}) : super(key: key);

  String imageUrl;
  String userName;
  String message;
  DateTime lastTime;
  int messageCount;
  List<MessageItem>? messageList;

  @override
  MessageItemGroupState createState() => MessageItemGroupState();
}

class MessageItemGroupState extends State<MessageItemGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.all(7),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: widget.imageUrl.contains("http") ? Image.network(widget.imageUrl) : Image.asset(widget.imageUrl),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userName, style: AppData.MainTheme.textTheme.subtitle1),
                Text(widget.message, style: AppData.MainTheme.textTheme.subtitle2),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("12:00", style: AppData.MainTheme.textTheme.bodyText1),
              SizedBox(height: 5),
              Container(
                width: 16,
                height: 16,
                child: Text("1", style: TextStyle(fontSize: 7, color: Colors.white)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.withOpacity(0.6)
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MessageItem extends StatefulWidget {
  MessageItem(this.message, this.time, {Key? key}) : super(key: key);

  String message;
  DateTime time;

  @override
  MessageItemState createState() => MessageItemState();
}

class MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

