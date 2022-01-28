import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/widgets/number_input_widget.dart';

enum GoodsItemCardType {
  normal,
  square,
  squareSmall,
  cart,
}

enum GoodsItemCardSellType {
  talent,
  goods,
}

class GoodsItemCartCard extends GoodsItemCard {
  GoodsItemCartCard(GoodsItem goodsData, {Key? key,
    onChanged,
    GoodsItemCardType showType = GoodsItemCardType.cart,
    GoodsItemCardSellType sellType = GoodsItemCardSellType.talent,
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
    TextStyle descStyle = const TextStyle(fontSize: 13, color: Colors.grey),
    TextStyle extraStyle = const TextStyle(fontSize: 12, color: Colors.black),
    TextStyle priceStyle = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.purple),
    TextStyle priceOrgStyle = const TextStyle(fontSize: 9, color: Colors.grey),
    TextStyle ribbonStyle = const TextStyle(fontSize: 8, color: Colors.white),
    Color ribbonColor = Colors.red,
    Alignment descAlign = Alignment.centerLeft,
    EdgeInsets padding = const EdgeInsets.fromLTRB(0, 5, 0, 5),
    Color backgroundColor = Colors.white,
    int descMaxLine = 1,
    double imageHeight = 60,
    double transPee = 2500.0,
    double couponPrice = 500.0,
    int cartCount = 1,
    bool isSelected = true,
  }) : super(goodsData, key: key,
    onChanged: onChanged,
    showType: showType,
    sellType: sellType,
    titleStyle: titleStyle,
    descStyle: descStyle,
    extraStyle: extraStyle,
    priceStyle: priceStyle,
    priceOrgStyle: priceOrgStyle,
    ribbonStyle: ribbonStyle,
    ribbonColor: ribbonColor,
    descAlign: descAlign,
    padding: padding,
    backgroundColor: backgroundColor,
    descMaxLine: descMaxLine,
    imageHeight: imageHeight,
    transPee: transPee,
    couponPrice: couponPrice,
    cartCount: cartCount,
    isSelected: isSelected,
  );
}

class GoodsItemSquareCard extends GoodsItemCard {
  GoodsItemSquareCard(GoodsItem goodsData, {Key? key,
    onChanged,
    GoodsItemCardType showType = GoodsItemCardType.square,
    GoodsItemCardSellType sellType = GoodsItemCardSellType.talent,
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
    TextStyle descStyle = const TextStyle(fontSize: 10, color: Colors.black),
    TextStyle extraStyle = const TextStyle(fontSize: 11, color: Colors.purple),
    TextStyle priceStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
    TextStyle priceOrgStyle = const TextStyle(fontSize: 9, color: Colors.grey),
    TextStyle ribbonStyle = const TextStyle(fontSize: 8, color: Colors.white),
    Color ribbonColor = Colors.red,
    Alignment descAlign = Alignment.centerLeft,
    EdgeInsets padding = const EdgeInsets.fromLTRB(10, 10, 10, 10),
    Color backgroundColor = Colors.white,
    int descMaxLine = 2,
    double imageHeight = 90,
  }) : super(goodsData, key: key,
    onChanged: onChanged,
    showType: showType,
    sellType: sellType,
    titleStyle: titleStyle,
    descStyle: descStyle,
    extraStyle: extraStyle,
    priceStyle: priceStyle,
    priceOrgStyle: priceOrgStyle,
    ribbonStyle: ribbonStyle,
    ribbonColor: ribbonColor,
    descAlign: descAlign,
    padding: padding,
    backgroundColor: backgroundColor,
    descMaxLine: descMaxLine,
    imageHeight: imageHeight,
  );
}

class GoodsItemSquareSmallCard extends GoodsItemCard {
  GoodsItemSquareSmallCard(GoodsItem goodsData, {Key? key,
    onChanged,
    GoodsItemCardType showType = GoodsItemCardType.square,
    GoodsItemCardSellType sellType = GoodsItemCardSellType.talent,
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black),
    TextStyle descStyle = const TextStyle(fontSize: 9, color: Colors.black),
    TextStyle extraStyle = const TextStyle(fontSize: 9, color: Colors.purple),
    TextStyle priceStyle = const TextStyle(fontSize: 9, color: Colors.black),
    TextStyle priceOrgStyle = const TextStyle(fontSize: 8, color: Colors.grey),
    TextStyle ribbonStyle = const TextStyle(fontSize: 8, color: Colors.white),
    Color ribbonColor = Colors.red,
    Alignment descAlign = Alignment.centerLeft,
    EdgeInsets padding = const EdgeInsets.fromLTRB(10, 10, 10, 10),
    Color backgroundColor = Colors.white,
    int descMaxLine = 1,
    double imageHeight = 90.0,
  }) : super(goodsData, key: key,
    onChanged: onChanged,
    showType: showType,
    sellType: sellType,
    titleStyle: titleStyle,
    descStyle: descStyle,
    extraStyle: extraStyle,
    priceStyle: priceStyle,
    priceOrgStyle: priceOrgStyle,
    ribbonStyle: ribbonStyle,
    ribbonColor: ribbonColor,
    descAlign: descAlign,
    padding: padding,
    backgroundColor: backgroundColor,
    descMaxLine: descMaxLine,
    imageHeight: imageHeight,
  );
}

class GoodsItemCard extends StatefulWidget {
  GoodsItemCard(this.goodsData, {Key? key,
    this.onChanged,
    this.showType = GoodsItemCardType.normal,
    this.sellType = GoodsItemCardSellType.talent,
    this.titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
    this.descStyle = const TextStyle(fontSize: 11, color: Colors.black),
    this.extraStyle = const TextStyle(fontSize: 11, color: Colors.purple),
    this.priceStyle = const TextStyle(fontSize: 11, color: Colors.black),
    this.priceOrgStyle = const TextStyle(fontSize: 11, color: Colors.grey),
    this.ribbonStyle = const TextStyle(fontSize: 8, color: Colors.white),
    this.ribbonColor = Colors.red,
    this.descAlign = Alignment.centerLeft,
    this.padding = const EdgeInsets.fromLTRB(20, 10, 20, 10),
    this.backgroundColor = Colors.white,
    this.descMaxLine = 2,
    this.imageHeight = 90.0,
    this.transPee = 0.0,
    this.couponPrice = 0.0,
    this.cartCount = 1,
    this.isSelected = false,
  }) : super(key: key);

  void Function(GoodsItemCard)? onChanged;

  // card show type..
  GoodsItemCardType showType;
  GoodsItemCardSellType sellType;

  GoodsItem   goodsData;

  TextStyle   titleStyle;
  TextStyle   descStyle;
  TextStyle   ribbonStyle;
  TextStyle   extraStyle;
  TextStyle   priceStyle;
  TextStyle   priceOrgStyle;
  Color       ribbonColor;
  Alignment   descAlign;
  EdgeInsets  padding;
  Color       backgroundColor;
  int         descMaxLine;

  bool isSelected;

  double imageHeight;
  double transPee; // 배송료..
  double couponPrice;

  int cartCount; // 구매갯수..

  @override
  State<StatefulWidget> createState() => GoodsItemCardState();
}

class GoodsItemCardState extends State<GoodsItemCard> {
  var priceFormat = NumberFormat('###,###,###,###.##');

  double? sumPrice; // price * cartCount
  double? totalPrice; // price * cartCount + transPee

  priceStr(price) {
    return price != null ? priceFormat.format(price) : 0;
  }

  refresh() {
    setState(() {
      sumPrice = 0;
      totalPrice = 0;
      if (widget.isSelected) {
        sumPrice = widget.goodsData.price! * widget.cartCount;
        totalPrice = sumPrice! + widget.transPee;
      }
      widget.onChanged!(widget);
      print("--> GoodsItemCardState refresh : ${widget.isSelected} / $sumPrice / $totalPrice");
    });
  }

  @override
  void initState() {
    super.initState();
    // sumTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.showType) {
      case GoodsItemCardType.normal:
      {
        return Container(
            padding: widget.padding,
            color: widget.backgroundColor,
            child: GestureDetector(
                onTap: () {
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        width: widget.imageHeight,
                        height: widget.imageHeight,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: widget.goodsData.imageUrl!.contains("http")
                              ? Image.network(widget.goodsData.imageUrl!)
                              : Image.asset(widget.goodsData.imageUrl!),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.goodsData.title!,
                              style: widget.titleStyle, maxLines: 1),
                          SizedBox(height: 5),
                          Text(
                              widget.goodsData.desc!, style: widget.descStyle,
                              maxLines: widget.descMaxLine),
                          SizedBox(height: 5),
                          priceTextStyle,
                        ],
                      ),
                    ),
                  ],
                )
            )
        );
      }
      case GoodsItemCardType.square:
      case GoodsItemCardType.squareSmall: {
        return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              padding: widget.padding,
              color: widget.backgroundColor,
              child: GestureDetector(
                onTap: () {
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: widget.goodsData.imageUrl!.contains("http")
                              ? Image.network(widget.goodsData.imageUrl!)
                              : Image.asset(widget.goodsData.imageUrl!),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(widget.goodsData.title!,style: widget.titleStyle, maxLines: 1),
                    SizedBox(height: 10),
                    Text(widget.goodsData.desc!, style: widget.descStyle, maxLines: widget.descMaxLine),
                    SizedBox(height: 10),
                    priceTextStyle,
                  ],
                )
            )
          )
        );
      }
      case GoodsItemCardType.cart: {
          return GestureDetector(
            onTap: () {
              setState(() {
                print("--> select item : ${widget.goodsData.id} / ${widget.goodsData.title}");
                AppData.setSearchEnable(false);
              });
            },
            child: Container(
              padding: widget.padding,
              // color: Colors.yellow,
                child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        // activeColor: Colors.purple,
                        value: widget.isSelected,
                        onChanged: (value) {
                          setState(() {
                            widget.isSelected = value!;
                            widget.cartCount  = widget.isSelected ? 1 : 0;
                            refresh();
                            print("--> check item : ${widget.goodsData.id} / ${widget.goodsData.title} / ${widget.isSelected}");
                          });
                        }
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: SizedBox(
                          width: widget.imageHeight,
                          height: widget.imageHeight,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: widget.goodsData.imageUrl!.contains("http")
                                ? Image.network(widget.goodsData.imageUrl!)
                                : Image.asset(widget.goodsData.imageUrl!),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: widget.imageHeight,
                          // color: Colors.yellow,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.goodsData.title!, style: widget.titleStyle, maxLines: 1),
                              Text(widget.goodsData.optionStr!, style: widget.descStyle, maxLines: widget.descMaxLine),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("상품금액 ", style: widget.extraStyle),
                                    Text("${priceStr(sumPrice)}원", style: widget.priceStyle),
                                    SizedBox(width: 10),
                                    Text("배송비 ", style: widget.extraStyle),
                                    Text("${priceStr(widget.transPee)}원", style: widget.priceStyle),
                                  ]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  cartTextStyle,
                ]
              )
            ),
          );
        }
      default: {
        return Container();
      }
    }
  }

  Widget get priceTextStyle {
    switch (widget.sellType) {
      case GoodsItemCardSellType.talent:
        {
          return Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("거리 ", style: widget.descStyle),
                      Text("${priceStr(widget.goodsData.distance)}km",
                          style: widget.extraStyle),
                      SizedBox(width: 10),
                      Text("최근 거래 ", style: widget.descStyle),
                      Text("${priceStr(widget.goodsData.trades)}km",
                          style: widget.extraStyle),
                    ]
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.sms, size: 15,
                        color: Colors.grey.withOpacity(0.5)),
                    SizedBox(width: 5),
                    Text("${widget.goodsData.comments}",
                        style: widget.descStyle),
                    SizedBox(width: 10),
                    Icon(Icons.favorite, size: 15,
                        color: Colors.grey.withOpacity(0.5)),
                    SizedBox(width: 5),
                    Text("${widget.goodsData.likes}",
                        style: widget.descStyle),
                  ],
                ),
              ]
          );
        }
      default:
        {
          return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${priceStr(widget.goodsData.price)}원",
                    style: widget.priceStyle),
                SizedBox(width: 5),
                Text("${priceStr(widget.goodsData.priceOrg)}원", style: TextStyle(
                    fontSize: widget.priceOrgStyle.fontSize,
                    color: widget.priceOrgStyle.color,
                    decoration: TextDecoration.lineThrough)),
                Expanded(
                  child: SizedBox(),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sms, size: 15,
                          color: Colors.grey.withOpacity(0.5)),
                      Text("${priceStr(widget.goodsData.comments)}",
                          style: widget.descStyle),
                      Icon(Icons.favorite, size: 15,
                          color: Colors.grey.withOpacity(0.5)),
                      Text("${priceStr(widget.goodsData.likes)}", style: widget.descStyle),
                    ]
                ),
              ]
          );
        }
    }
  }

  Widget get cartTextStyle {
    switch (widget.sellType) {
      case GoodsItemCardSellType.talent:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NumberInputWidget(widget.cartCount, onChanged: (value) {
                setState(() {
                  widget.cartCount = value;
                  widget.isSelected = widget.cartCount > 0;
                  sumPrice = widget.goodsData.price! * widget.cartCount;
                  refresh();
                });
              }),
              SizedBox(width: 10),
              TextButton(
                  onPressed: () {},
                  child: Text("삭 제", style: widget.titleStyle),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.grey)
                          )
                      )
                  )
              ),
              SizedBox(width: 10),
              TextButton(
                  onPressed: () {},
                  child: Text("바로 구매", style: widget.titleStyle),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.black, width: 2)
                          )
                      ),
                  )
              ),
            ],
          );
        }
      default:
        {
          return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${priceStr(widget.goodsData.price)}원",
                    style: widget.priceStyle),
                SizedBox(width: 5),
                Text("${priceStr(widget.goodsData.priceOrg)}원", style: TextStyle(
                    fontSize: widget.priceOrgStyle.fontSize,
                    color: widget.priceOrgStyle.color,
                    decoration: TextDecoration.lineThrough)),
                Expanded(
                  child: SizedBox(),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sms, size: 15,
                          color: Colors.grey.withOpacity(0.5)),
                      Text("${priceStr(widget.goodsData.comments)}",
                          style: widget.descStyle),
                      Icon(Icons.favorite, size: 15,
                          color: Colors.grey.withOpacity(0.5)),
                      Text("${priceStr(widget.goodsData.likes)}", style: widget.descStyle),
                    ]
                ),
              ]
          );
        }
    }
  }
}