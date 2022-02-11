import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {

  final _searchTextController = TextEditingController();
  final _focusNode1 = FocusNode();
  final _height = 50.0;
  final _itemHeight = 46.0;

  var _searchText = "";

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

  @override
  void initState() {
    super.initState();
    // _focusNode1.addListener(() {
    //   Future.delayed(const Duration(milliseconds: 200), () {
    //     setState(() {
    //       AppData.isSearchOn = _focusNode1.hasFocus;
    //     });
    //   });
    // });
  }

  setHistoryListShow(status) {
    setState(() {
      AppData.isSearchOn = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      // height: _height,
        padding: EdgeInsets.fromLTRB(10,0,10,10),
        alignment: Alignment.center,
        constraints: BoxConstraints(
            minHeight: _height, minWidth: double.infinity, maxHeight: double.infinity
        ),
        // height: _newHistoryList.length * _itemHeight > 300 ? 300 : _newHistoryList.length * _itemHeight < 10 ? 10 : _newHistoryList.length * _itemHeight,
        child: Column(
          children: [
            SizedBox(height: 15),
            Stack(
                children: [
                  Container(
                  height: _height * 0.7,
                  // color: Colors.green,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Image.asset("assets/ui/main_top/Search_Bar_00_L.png"),
                      Expanded(
                        child: Image.asset(
                            "assets/ui/main_top/Search_Bar_00_C.png",
                            fit: BoxFit.fill),
                      ),
                      Image.asset("assets/ui/main_top/Search_Bar_00_R.png"),
                    ],
                  ),
                ),
                Container(
                    height: _height * 0.7,
                    padding: EdgeInsets.only(left: 8),
                    // color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              // alignment: Alignment.center,
                              height: _height * 0.7,
                              padding: EdgeInsets.only(left: 5.0),
                              child: TextField(
                                focusNode: _focusNode1,
                                controller: _searchTextController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.headline2,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(bottom: 15),
                                  hintText: '검색',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12),
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
            ],
          ),
          Visibility(
            visible: AppData.isSearchOn,
            child: searchHistoryListView,
          ),
        ]
      )
    );
  }

  Widget get searchHistoryListView {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        constraints: BoxConstraints(
            minHeight: 10, minWidth: double.infinity, maxHeight: 300
        ),
        child: ListView.builder(
          // padding: EdgeInsets.all(10.0),
          // controller: _controller,
          shrinkWrap: true,
          itemCount: _newHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            alignment: Alignment.centerLeft,
                            child: Text(_newHistoryList[index],
                                style: Theme.of(context).textTheme.headline1),
                          ),
                          Visibility(
                              visible: index < _newHistoryList.length - 1,
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
                      print("--> select item : $index / $_searchText");
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
    super.dispose();
  }
}

