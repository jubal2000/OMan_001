import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/goods_item.dart';

enum GoodsItemCardType {
  normal,
  square,
  squareSmall,
}

enum GoodsItemCardSellType {
  talent,
  goods,
}

class GoodsItemSquareCard extends GoodsItemCard {
  GoodsItemSquareCard(GoodsItem goodsData, {Key? key,
    GoodsItemCardType showType = GoodsItemCardType.square,
    GoodsItemCardSellType sellType = GoodsItemCardSellType.talent,
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
    TextStyle descStyle = const TextStyle(fontSize: 10, color: Colors.black),
    TextStyle distanceStyle = const TextStyle(fontSize: 11, color: Colors.purple),
    TextStyle priceStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
    TextStyle priceOrgStyle = const TextStyle(fontSize: 9, color: Colors.grey),
    TextStyle ribbonStyle = const TextStyle(fontSize: 8, color: Colors.white),
    Color ribbonColor = Colors.red,
    Alignment descAlign = Alignment.centerLeft,
    EdgeInsets padding = const EdgeInsets.fromLTRB(10, 10, 10, 10),
    Color backgroundColor = Colors.white,
    int descMaxLine = 2,
    double imageHeight = 0,
  }) : super(goodsData, key: key,
    showType: showType,
    sellType: sellType,
    titleStyle: titleStyle,
    descStyle: descStyle,
    distanceStyle: distanceStyle,
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
    GoodsItemCardType showType = GoodsItemCardType.square,
    GoodsItemCardSellType sellType = GoodsItemCardSellType.talent,
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black),
    TextStyle descStyle = const TextStyle(fontSize: 9, color: Colors.black),
    TextStyle distanceStyle = const TextStyle(fontSize: 9, color: Colors.purple),
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
    showType: showType,
    sellType: sellType,
    titleStyle: titleStyle,
    descStyle: descStyle,
    distanceStyle: distanceStyle,
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
    this.showType = GoodsItemCardType.normal,
    this.sellType = GoodsItemCardSellType.talent,
    this.titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
    this.descStyle = const TextStyle(fontSize: 11, color: Colors.black),
    this.distanceStyle = const TextStyle(fontSize: 11, color: Colors.purple),
    this.priceStyle = const TextStyle(fontSize: 11, color: Colors.black),
    this.priceOrgStyle = const TextStyle(fontSize: 11, color: Colors.grey),
    this.ribbonStyle = const TextStyle(fontSize: 8, color: Colors.white),
    this.ribbonColor = Colors.red,
    this.descAlign = Alignment.centerLeft,
    this.padding = const EdgeInsets.fromLTRB(20, 10, 20, 10),
    this.backgroundColor = Colors.white,
    this.descMaxLine = 2,
    this.imageHeight = 90.0,
  }) : super(key: key);

  // card show type..
  GoodsItemCardType showType;
  GoodsItemCardSellType sellType;

  GoodsItem   goodsData;

  TextStyle   titleStyle;
  TextStyle   descStyle;
  TextStyle   ribbonStyle;
  TextStyle   distanceStyle;
  TextStyle   priceStyle;
  TextStyle   priceOrgStyle;
  Color       ribbonColor;
  Alignment   descAlign;
  EdgeInsets  padding;
  Color       backgroundColor;
  int         descMaxLine;

  double imageHeight;

  @override
  State<StatefulWidget> createState() => GoodsItemCardState();
}

class GoodsItemCardState extends State<GoodsItemCard> {
  @override
  void initState() {
    super.initState();
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
      default: {
        return Container();
      }
    }
  }

  Widget get priceTextStyle {
    if (widget.sellType == GoodsItemCardSellType.talent) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("거리 ", style: widget.descStyle),
              Text("${widget.goodsData.distance}km", style: widget.distanceStyle),
              SizedBox(width: 10),
              Text("최근 거래 ", style: widget.descStyle),
              Text("${widget.goodsData.trades}km",style: widget.distanceStyle),
            ]
          ),
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.sms, size: 15, color: Colors.grey.withOpacity(0.5)),
              SizedBox(width: 5),
              Text("${widget.goodsData.comments}",
                  style: widget.descStyle),
              SizedBox(width: 10),
              Icon(Icons.favorite, size: 15, color: Colors.grey.withOpacity(0.5)),
              SizedBox(width: 5),
              Text("${widget.goodsData.likes}",
                  style: widget.descStyle),
            ],
          ),
        ]
      );
    } else {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${widget.goodsData.price}원", style: widget.priceStyle),
            SizedBox(width: 5),
            Text("${widget.goodsData.priceOrg}원", style: TextStyle(fontSize: widget.priceOrgStyle.fontSize, color: widget.priceOrgStyle.color, decoration: TextDecoration.lineThrough)),
            Expanded(
              child: SizedBox(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.sms, size: 15, color: Colors.grey.withOpacity(0.5)),
                SizedBox(width: 5),
                Text("${widget.goodsData.comments}", style: widget.descStyle),
                SizedBox(width: 10),
                Icon(Icons.favorite, size: 15, color: Colors.grey.withOpacity(0.5)),
                SizedBox(width: 5),
                Text("${widget.goodsData.likes}", style: widget.descStyle),
              ]
            ),
          ]
        );
    }
  }
}