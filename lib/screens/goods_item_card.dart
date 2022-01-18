import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/goods_item.dart';

class GoodsItemCard extends StatefulWidget {
  GoodsItemCard(this.goodsData, {Key? key,
    // this.title = "",
    // this.desc = "",
    // this.ribbon = "",
    // this.price = 0,
    // this.priceOrg = 0,
    // this.saleRatio = 0,
    // this.distance = 0,
    // this.trades = 0,
    // this.comments = 0,
    // this.likes = 0,
    this.titleStyle = const TextStyle(fontFamily: "NotoSans", fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
    this.descStyle = const TextStyle(fontSize: 11, color: Colors.black),
    this.distanceStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.purple),
    this.ribbonStyle = const TextStyle(fontSize: 8, color: Colors.white),
    this.ribbonColor = Colors.red,
    this.descAlign = Alignment.centerLeft,
    this.margin = const EdgeInsets.fromLTRB(20, 10, 20, 10),
    this.backgroundColor = Colors.black,
    this.height = 90.0,
  }) : super(key: key);

  // String      imageUrl;
  // String      title;
  // String      desc;
  // String      ribbon;

  GoodsItem   goodsData;

  TextStyle   titleStyle;
  TextStyle   descStyle;
  TextStyle   ribbonStyle;
  Color       ribbonColor;
  TextStyle   distanceStyle;
  EdgeInsets  margin;
  Color       backgroundColor;
  Alignment   descAlign;

  double height;

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
    return Container(
      margin: widget.margin,
      child: GestureDetector(
        onTap: () {

        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                width:  widget.height,
                height: widget.height,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: widget.goodsData.imageUrl.contains("http") ? Image.network(widget.goodsData.imageUrl) : Image.asset(widget.goodsData.imageUrl),
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.goodsData.title, style: widget.titleStyle, maxLines: 1),
                  SizedBox(height: 5),
                  Text(widget.goodsData.desc, style: widget.descStyle, maxLines: 1),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("거리 ", style: widget.descStyle),
                      Text("${widget.goodsData.distance}km", style: widget.distanceStyle),
                      SizedBox(width: 15),
                      Text("최근 거래 ", style: widget.descStyle),
                      Text("${widget.goodsData.trades}km", style: widget.distanceStyle),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(opacity: 0.1,
                        child: Icon(Icons.sms, size: 15),
                      ),
                      SizedBox(width: 5),
                      Text("${widget.goodsData.comments}", style: widget.descStyle),
                      SizedBox(width: 10),
                      Opacity(opacity: 0.1,
                        child: Icon(Icons.favorite, size: 15),
                      ),
                      SizedBox(width: 5),
                      Text("${widget.goodsData.likes}", style: widget.descStyle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}