import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/data/goods_item.dart';
import 'package:oman_001/data/history_item.dart';
import 'package:oman_001/utils/utils.dart';
import 'package:oman_001/widgets/number_input_widget.dart';
import 'package:video_player/video_player.dart';

enum HistoryItemCardType {
  normal,
  square,
  squareSmall,
}

class HistoryItemCard extends StatefulWidget {
  HistoryItemCard(this.historyData, {Key? key,
    this.onChanged,
    this.showType = HistoryItemCardType.normal,
    this.titleStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
    this.descStyle = const TextStyle(fontSize: 11, color: Colors.black),
    this.ribbonStyle = const TextStyle(fontSize: 8, color: Colors.white),
    this.ribbonColor = Colors.red,
    this.descAlign = Alignment.centerLeft,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.backgroundColor = Colors.white,
    this.descMaxLine = 2,
    this.isSelected = false,
    this.isSelectable = false,
    this.isPlayable = true,
  }) : super(key: key);

  void Function(HistoryItemCard)? onChanged;

  // card show type..
  HistoryItemCardType showType;

  HistoryItem   historyData;

  TextStyle   titleStyle;
  TextStyle   descStyle;
  TextStyle   ribbonStyle;
  Color       ribbonColor;
  Alignment   descAlign;
  EdgeInsets  padding;
  Color       backgroundColor;
  int         descMaxLine;

  bool isSelected;
  bool isSelectable;
  bool isPlayable;

  @override
  State<StatefulWidget> createState() => HistoryItemCardState();
}

class HistoryItemCardState extends State<HistoryItemCard> {
  var priceFormat = NumberFormat('###,###,###,###.##');


  double? sumPrice; // price * cartCount
  double? totalPrice; // price * cartCount + transPee

  late HistoryItem _item;
  late VideoPlayerController _playController;
  late Future<void> _playCalculator;

  priceStr(price) {
    return price != null ? priceFormat.format(price) : 0;
  }

  refresh() {
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    _item = widget.historyData;
    _playController = _item.url!.contains("http")
        ? VideoPlayerController.network(_item.url!)
        : VideoPlayerController.asset(_item.url!);
    _playCalculator = _playController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.showType) {
      case HistoryItemCardType.normal:
      {
        return Container(
          padding: widget.padding,
          color: widget.backgroundColor,
          child: FutureBuilder(
            future: _playCalculator,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  constraints: BoxConstraints.expand(),
                  color: Colors.black,
                  // VideoPlayer의 종횡비를 제한하세요.
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Center(
                            child: AspectRatio(
                                aspectRatio: _playController.value
                                    .aspectRatio,
                                child: VideoPlayer(_playController)
                            )
                        ),
                        onTapDown: (_) {
                          setState(() {
                            // AppData.isShowPlayerInfo = !AppData.isShowPlayerInfo;
                          });
                        },
                      ),
                      VideoProgressIndicator(
                        _playController,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                            backgroundColor: Colors.grey,
                            bufferedColor: Colors.white,
                            playedColor: Colors.purple
                        ),
                      ),
                      // Column(
                      //   children: <Widget> [
                      //     Align(
                      //       alignment: Alignment.bottomLeft,
                      //       child: PlayerOverlayScreen(widget.userInfo.historyData![widget.historyId]!, controller: widget.controller, onScreenClosed: (isShow) {
                      //         setState(() {
                      //           AppData.isShowPlayerInfo = isShow;
                      //         });
                      //       })
                      //     ),
                      //     Expanded(
                      //       child: Align(
                      //           alignment: Alignment.bottomRight,
                      //           child: UserOverlayScreen(widget.userInfo, onButtonSelect: (selectId) {
                      //             setState(() {
                      //
                      //             });
                      //           })
                      //         )
                      //       )
                      //   ]
                      // )
                    ],
                  ),
                );
                // return VideoPlayer(_controller!);
              } else {
                return getLoadingCircle(30);
              }
            },
          ),
        );
      }
      default:
      {
        return Container();
      }
    }
  }
}