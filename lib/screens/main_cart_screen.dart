import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/data/videos_firebase.dart';
import 'package:oman_001/utils/tik_tok_icons_icons.dart';
import 'package:oman_001/widgets/search_widget.dart';

import 'goods_item_card.dart';

class MainCartScreen extends StatefulWidget {
  MainCartScreen({Key? key}) : super(key: key);

  final List<MainCartTab> _tabList = [
    MainCartTab(0, "상품"),
    MainCartTab(1, "쿠폰"),
  ];

  var _currentTab = 0;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<MainCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(defaultTargetPlatform == TargetPlatform.android ? 20 : 50), // here the desired height
          child: AppBar(
            title: Text('장바구니', style: AppData.MainTheme.textTheme.headline1),
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

class MainCartTab extends StatefulWidget {
  MainCartTab(this.selectedTab, this.title, { Key? key }) : super(key: key);

  final int selectedTab;
  final String title;

  Widget getTab() {
    return Tab(text: title, height: 40);
  }

  @override
  _MainCartTabState createState() => _MainCartTabState();
}


class CartItemInfo {
  CartItemInfo(this.card, this.key);
  GoodsItemCartCard? card;
  GlobalKey? key;
}

class _MainCartTabState extends State<MainCartTab> with AutomaticKeepAliveClientMixin<MainCartTab> {
  final _scrollController = PageController(viewportFraction: 1, keepPage: true);
  var priceFormat = NumberFormat('###,###,###,###.##');

  List<CartItemInfo>? _itemList;
  Future<List<GoodsItem>>? _calculation;

  var _sumPrice = 0.0;
  var _totalPrice = 0.0;
  var _couponPrice = 0.0;
  var _transPee = 0.0;
  var _selectCount = 0;
  var _checkAll = true;

  refresh() {
      _sumPrice = 0;
      _couponPrice = 0;
      _transPee = 0;
      _selectCount = 0;
      for (var item in _itemList!) {
        if (item.card!.isSelected) {
          _sumPrice += item.card!.goodsData.price! * item.card!.cartCount;
          _couponPrice += item.card!.couponPrice;
          _transPee += item.card!.transPee;
          _selectCount++;
        }
      }
      _totalPrice = _sumPrice + _transPee - _couponPrice;
      print("--> refresh : $_selectCount");
  }

  refreshSelectAll() {
    for (var item in _itemList!) {
      item.card!.isSelected = _checkAll;
      item.card!.cartCount  = _checkAll ? 1 : 0;
      if (item.key!.currentState != null) {
        var key = item.key!.currentState as GoodsItemCardState;
        key.refresh();
      }
    }
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
    switch (widget.selectedTab) {
      case 0:
        {
          return FutureBuilder(
            future: _calculation,
            builder: (BuildContext context, AsyncSnapshot<List<GoodsItem>> snapshot) {
              print("--> _MainCartTabState : ${snapshot.hasData} / ${AppData.isStoreDataReady}");
              if (snapshot.hasData || AppData.isStoreDataReady) {
                if (!AppData.isStoreDataReady) {
                  AppData.goodsList = snapshot.data!.map((item) => GoodsItemCard(item)).toList();
                  AppData.isStoreDataReady = true;
                }
                _itemList ??= AppData.goodsList.map((item) {
                    var key = GlobalKey();
                    var card = GoodsItemCartCard(item.goodsData, key: key, onChanged: (data) {
                      setState(() {
                        refresh();
                      });
                    });
                    return CartItemInfo(card, key);
                }).toList();

                refresh();

                return Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              // activeColor: Colors.purple,
                                value: _checkAll,
                                onChanged: (value) {
                                  setState(() {
                                    _checkAll = value!;
                                    print("--> check all item : $_checkAll");
                                    refreshSelectAll();
                                  });
                                }
                            ),
                            Expanded(
                                child: Text("전체 선택 ($_selectCount/${_itemList?.length})", style: Theme.of(context).textTheme.headline1),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text("선택 삭제", style: Theme.of(context).textTheme.headline2),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            side: BorderSide(color: Colors.grey)
                                        )
                                    )
                                )
                            ),
                          ]
                        ),
                        Divider(color: Colors.grey),
                        Flexible(
                          child: ListView.separated(
                            // shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            controller: _scrollController,
                            itemCount: _itemList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _itemList![index].card!;
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider(color: Colors.grey);
                            },
                          ),
                        ),
                        Divider(color: Colors.grey),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("총 주문 금액", style: Theme.of(context).textTheme.headline2),
                                    Text("${priceFormat.format(_sumPrice)}원", style: AppData.MainTheme.textTheme.headline2),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("총 쿠폰할인", style: Theme.of(context).textTheme.headline2),
                                    Text("${priceFormat.format(_couponPrice)}원", style: AppData.MainTheme.textTheme.headline2),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("총 배송비", style: Theme.of(context).textTheme.headline2),
                                    Text("${priceFormat.format(_transPee)}원", style: AppData.MainTheme.textTheme.headline2),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("총 결제 금액", style: Theme.of(context).textTheme.headline1),
                                    Text("${priceFormat.format(_totalPrice)}원", style: AppData.MainTheme.textTheme.headline1),
                                  ],
                                ),
                              ]
                          ),
                        ),
                        Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(2.0),
                                              )
                                          ),
                                          // foregroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
                                          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.withOpacity(0.2)),
                                        ),
                                        onPressed: () {},
                                        child: Text("선택 주문", style: Theme.of(context).textTheme.headline2)
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text("전체 주문", style: Theme.of(context).textTheme.headline1),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(2.0),
                                            )
                                        ),
                                        // foregroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.75)),
                                        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.withOpacity(0.5)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ]
                  ),
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
