import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:oman_001/main_my/setup_screen.dart';
import 'package:oman_001/main_store/main_store.dart';
import 'package:oman_001/screens/main_cart_screen.dart';
import 'package:oman_001/screens/messages_screen.dart';
import 'package:oman_001/utils/utils.dart';

import 'data/app_data.dart';

class MainAppBar extends StatefulWidget {
  MainAppBar(this.screens, this.currentMenu, { Key? key}) : super(key: key);

  List<Widget> screens;
  int currentMenu;
  String? selectedTerm;

  @override
  MainAppBarState createState() => MainAppBarState();
}

class MainAppBarState extends State<MainAppBar> {
  final _height = 50.0;
  final _iconSize = 40.0;
  var _searchText = "";

  final _scaffoldKey = GlobalKey();
  List<String>? filteredSearchHistory;

  static final List<String> _searchHistory = [
    "Apple",
    "Apricot",
    "Banana",
    "Blackberry",
    "Coconut",
    "Date",
    "Fig",
    "Gooseberry",
    "Grapes",
    "Lemon",
    "Litchi",
    "Mango",
    "Orange",
    "Papaya",
    "Peach",
    "Pineapple",
    "Pomegranate",
    "Starfruit"
  ];

  List<String> _newHistoryList = List.from(_searchHistory);

  final _searchTextController = TextEditingController();
  // final _focusNode1 = FocusNode();
  // final _focusNode2 = FocusNode();

  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode1.addListener(() {
  //     setState(() {
  //       print(_focusNode1.hasFocus);
  //       if (_focusNode1.hasFocus) {
  //         AppData.isSearchOn = true;
  //       } else {
  //         Future.delayed(const Duration(milliseconds: 200), () {
  //           setState(() {
  //             AppData.isSearchOn = false;
  //           });
  //         });
  //       }
  //     });
  //   });
  //   _focusNode2.addListener(() {
  //     setState(() {
  //       print(_focusNode2.hasFocus);
  //       if (_focusNode2.hasFocus) {
  //         AppData.isSearchOn = true;
  //       } else {
  //         Future.delayed(const Duration(milliseconds: 200), () {
  //           setState(() {
  //             AppData.isSearchOn = false;
  //           });
  //         });
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: _scaffoldKey,
      color: Colors.transparent,
      child: Container(
          height: AppData.isSearchOn ? MediaQuery.of(context).size.height : _height,
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.topCenter,
          // color: _isSearchOn ? Colors.black.withOpacity(0.5) : Colors.transparent,
          child: Row(
            children: <Widget> [
              Visibility(
                visible: widget.currentMenu == MainMenuID.home,
                child: SizedBox(
                  height: _height,
                  width: _height,
                  child: Image.asset(widget.currentMenu == MainMenuID.home ? "assets/ui/main_top/Logo_02.png" : "assets/ui/main_top/Logo_01.png"),
                ),
              ),
              Visibility(
                visible: widget.currentMenu == MainMenuID.my,
                child: Container(
                  // color: Colors.red,
                    height: _iconSize,
                    width: _iconSize,
                    child: IconButton(
                      icon: Image.asset("assets/ui/main_top/Setup_01.png"),
                      onPressed: () {
                        // AppData.mainDrawerKey.currentState?.openDrawer();
                        Navigator.of(context).push(SecondPageRoute(SetupScreen()));
                      },
                    )
                ),
              ),
              Expanded(
                  child: Stack(
                    children: [
                      Visibility(
                        visible: widget.currentMenu == MainMenuID.search,
                        child: Container(
                        // color: Colors.yellow,
                        padding: EdgeInsets.fromLTRB(10, 2, 5, 0),
                        child: Column(
                          children:[
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: _height * 0.6,
                                  // color: Colors.green,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(right: 8),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/ui/main_top/Search_Bar_00_L.png"),
                                      Expanded(
                                        child: Image.asset("assets/ui/main_top/Search_Bar_00_C.png", fit: BoxFit.fill),
                                      ),
                                      Image.asset("assets/ui/main_top/Search_Bar_00_R.png"),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8),
                                  // color: Colors.yellow,
                                  child: Row(
                                    children: [
                                      Opacity(
                                        opacity: 0.2,
                                        child: Icon(
                                          Icons.search,
                                          size: 20.0,
                                          color: Colors.black,
                                        )
                                      ),
                                      Expanded(
                                        child: Container(
                                          // color: Colors.blue.withOpacity(0.5),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: SingleChildScrollView(
                                            child: TextField(
                                              // focusNode: _focusNode1,
                                              controller: _searchTextController,
                                              maxLines: 1,
                                              keyboardType: TextInputType.text,
                                              style: AppData.MainTheme.textTheme.headline2,
                                              decoration: InputDecoration(
                                                hintText: '검색',
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (text) {
                                                setState(() {
                                                  _searchText = text;
                                                  _newHistoryList = _searchHistory.where((string) => string.toLowerCase().contains(_searchText.toLowerCase())).toList();
                                                  AppData.isSearchOn = _newHistoryList.isNotEmpty;
                                                  }
                                                );
                                              },
                                              onTap: () {
                                                setState(() {
                                                  _newHistoryList = _searchHistory.where((string) => string.toLowerCase().contains(_searchText.toLowerCase())).toList();
                                                  AppData.isSearchOn = _newHistoryList.isNotEmpty;
                                                });
                                              },
                                            )
                                          )
                                        )
                                      ),
                                      Container(
                                        // color: Colors.green.withOpacity(0.5),
                                        child: Opacity(
                                          opacity: _searchText.isNotEmpty ? 0.2 : 0,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              size: 20.0,
                                              color: Colors.black,
                                            ), onPressed: () {
                                              setState(() {
                                                _searchTextController.clear();
                                                _searchText = "";
                                              });
                                            },
                                          )
                                        ),
                                      ),
                                    ]
                                  )
                                ),
                              ]
                            ),
                            Visibility(
                              visible: AppData.isSearchOn,
                                child: searchListModal,
                            ),
                            ]
                          ),
                        ),
                      ),
                    Visibility(
                      visible: widget.currentMenu == MainMenuID.store,
                      child: Stack(
                          children: [
                            Container(
                              height: _height * 0.6,
                              // color: Colors.yellow,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(left: _height * 1.2, right: 10, top: 9),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Image.asset("assets/ui/main_top/Search_Bar_00_C.png", fit: BoxFit.fill),
                                  ),
                                  Image.asset("assets/ui/main_top/Search_Bar_00_R.png"),
                                ],
                              ),
                            ),
                            Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: _height * 1.8, right: defaultTargetPlatform == TargetPlatform.android ? 3 : 8),
                                      alignment: Alignment.topCenter,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              // color: Colors.yellow,
                                              padding: EdgeInsets.only(left: 5.0),
                                              child: SingleChildScrollView(
                                                child: TextField(
                                                  style: AppData.MainTheme.textTheme.headline2,
                                                  // focusNode: _focusNode2,
                                                  controller: _searchTextController,
                                                  maxLines: 1,
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    hintText: '검색',
                                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                                    border: InputBorder.none,
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    _searchText = text;
                                                    _newHistoryList = _searchHistory.where((string) => string.toLowerCase().contains(_searchText.toLowerCase())).toList();
                                                    AppData.isSearchOn = _newHistoryList.isNotEmpty;
                                                  });
                                                },
                                                  onTap: () {
                                                    setState(() {
                                                      _newHistoryList = _searchHistory.where((string) => string.toLowerCase().contains(_searchText.toLowerCase())).toList();
                                                      AppData.isSearchOn = _newHistoryList.isNotEmpty;
                                                    });
                                                  },
                                                )
                                              )
                                            )
                                          ),
                                          Opacity(
                                            opacity: 0.2,
                                            child: IconButton(
                                              icon: Icon(
                                                _searchText.isEmpty ? Icons.search : Icons.close,
                                                size: 20.0,
                                                color: Colors.black,
                                              ), onPressed: () {
                                              setState(() {
                                                _searchTextController.clear();
                                                _searchText = "";
                                              });
                                            },
                                          )
                                        ),
                                      ]
                                    )
                                  ),
                                  Visibility(
                                    visible: AppData.isSearchOn,
                                    child: searchListModal,
                                  ),
                                ]
                            ),
                            Container(
                              padding: EdgeInsets.only(top:5),
                              alignment: Alignment.topLeft,
                              child: Stack(
                                  alignment: Alignment.topLeft,
                              children: [
                                SizedBox(
                                  width: _height * 2,
                                  height: _height * 0.8,
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Image.asset(AppData.storeMode == StoreMode.talent ? "assets/ui/main_top/btn_toggle_01.png" : "assets/ui/main_top/btn_toggle_00.png", fit: BoxFit.fill),
                                    onPressed: () {
                                      setState(() {
                                        AppData.storeMode = 1 - AppData.storeMode.toInt();
                                        var scr = widget.screens[3] as MainStoreScreen;
                                        scr.update(AppData.storeMode);
                                      });
                                    }
                                  ),
                                ),
                                IgnorePointer(
                                  child: Container(
                                    width: _height * 2,
                                    height: _height * 0.8,
                                    alignment: Alignment.centerLeft,
                                    padding: AppData.storeMode == StoreMode.talent ? EdgeInsets.only(left:20) : EdgeInsets.only(left:25),
                                    margin: EdgeInsets.only(bottom: 1),
                                    child: Row(
                                        children: [
                                          Text("재능", style: AppData.storeMode == StoreMode.talent ? AppData.MainTheme.textTheme.subtitle1 : AppData.MainTheme.textTheme.subtitle2),
                                          SizedBox(width: 9),
                                          Text("상품", style: AppData.storeMode == StoreMode.goods ? AppData.MainTheme.textTheme.subtitle1 : AppData.MainTheme.textTheme.subtitle2),
                                      ]
                                    ),
                                  ),
                                ),
                              ]
                            )
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
              Container(
                // color: Colors.blue,
                alignment: Alignment.topCenter,
               padding: EdgeInsets.only(top: 5),
               child: Row(
                children: <Widget> [
                  Visibility(
                    visible: widget.currentMenu == MainMenuID.home,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        customButton: SizedBox(
                          width: 22,
                          height: 22,
                          child: Image.asset("assets/ui/main_top/Add_00.png"),
                        ),
                        customItemsIndexes: const [3],
                        customItemsHeight: 8,
                        items: [
                          ...MenuItems.firstItems.map(
                                (item) =>
                                DropdownMenuItem<MenuItem>(
                                  value: item,
                                  child: MenuItems.buildItem(item),
                                ),
                          ),
                        ],
                        onChanged: (value) {
                          MenuItems.onChanged(context, value as MenuItem);
                        },
                        itemHeight: 45,
                        dropdownWidth: 140,
                        buttonHeight: _iconSize,
                        buttonWidth: _iconSize,
                        itemPadding: const EdgeInsets.only(left: 16, right: 16),
                        offset: const Offset(0, 8),
                      ),
                    )
                  ),
                  SizedBox(width: 13),
                  Container(
                    // color: Colors.red,
                      height: _iconSize,
                      width: _iconSize,
                      child: IconButton(
                        icon: Image.asset("assets/ui/main_top/" + (widget.currentMenu == MainMenuID.home ? "Message_00.png" : "Message_01.png")),
                        onPressed: () {
                          Navigator.of(context).push(SecondPageRoute(MessagesScreen()));
                        },
                      )
                  ),
                  Container(
                      // color: Colors.red,
                      width: _iconSize,
                      height: _iconSize,
                      child: IconButton(
                        icon: Image.asset("assets/ui/main_top/" + (widget.currentMenu == MainMenuID.home ? "Shopping_00.png" : "Shopping_01.png")),
                        onPressed: () {
                          Navigator.of(context).push(SecondPageRoute(MainCartScreen()));
                        },
                    )
                  ),
                ],
              ),
              ),
            ],
          )
      )
    );
  }

  Widget get searchListModal {
    // PageController _controller = PageController(viewportFraction: 1, keepPage: true);
  var _itemHeight = 46.0;

    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: _newHistoryList.length * _itemHeight > 300 ? 300 : _newHistoryList.length * _itemHeight < 10 ? 10 : _newHistoryList.length * _itemHeight,
        // constraints: BoxConstraints(
        //     minHeight: 20, minWidth: double.infinity, maxHeight: 300
        // ),
        child: ListView.builder(
          // padding: EdgeInsets.all(10.0),
          padding: EdgeInsets.zero,
          // controller: _controller,
          itemCount: _newHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: _itemHeight,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          alignment: Alignment.centerLeft,
                          child: Text(_newHistoryList[index], style: AppData.MainTheme.textTheme.headline1),
                        ),
                        Visibility(
                          visible: index < _newHistoryList.length-1,
                          child: Divider(
                            indent: 20,
                            endIndent: 20,
                            color: Colors.grey
                          )
                        ),
                      ]
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _searchText = _newHistoryList[index];
                      _searchTextController.text = _searchText;
                      _searchTextController.selection = TextSelection.fromPosition(TextPosition(offset: _searchText.length));
                      AppData.isSearchOn = false;
                    });
                  }
                ),
              );
            },
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
        )
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    // _focusNode1.dispose();
    // _focusNode2.dispose();
    super.dispose();
  }
}
