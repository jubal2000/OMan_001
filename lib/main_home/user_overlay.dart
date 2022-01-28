import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/user_item.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class UserOverlayScreen extends StatefulWidget {
  final Function? onButtonSelect;
  UserItem userInfo;

  UserOverlayScreen(
      this.userInfo,
      { Key? key, this.onButtonSelect }) : super(key: key);

  @override
  UserOverlayState createState() => UserOverlayState();
}

class UserOverlayState extends State<UserOverlayScreen> {
  final double _iconSpace = 15;
  final Size _iconSize = Size(30, 30);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0, right: 10),
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Colors.yellow.withOpacity(0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              SizedBox(
                  height: _iconSize.width,
                  width: _iconSize.height,
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                      },
                      icon: Image.asset("assets/ui/main_right/More.png")
                  )
              ),
              SizedBox(height: _iconSpace),
              SizedBox(
                  height: _iconSize.width,
                  width: _iconSize.height,
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                      },
                      icon: Image.asset("assets/ui/main_right/Shop_00.png")
                  )
              ),
              SizedBox(height: _iconSpace* 1.5),
              SizedBox(
                  height: _iconSize.width,
                  width: _iconSize.height,
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                      },
                      icon: Image.asset("assets/ui/main_right/Share.png")
                  )
              ),
              SizedBox(height: _iconSpace),
              SizedBox(
                  width: _iconSize.width,
                  height: _iconSize.height * 1.75,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                    },
                    icon: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget> [
                          Image.asset("assets/ui/main_right/Comment.png"),
                          SizedBox(height: 2),
                          Text(
                            "${widget.userInfo.commentData!.length}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ]
                    ),
                  )
              ),
              SizedBox(height: _iconSpace),
              SizedBox(
                width: _iconSize.width,
                height: _iconSize.height * 1.75,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                  },
                  icon: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Image.asset("assets/ui/main_right/Good.png"),
                      SizedBox(height: 2),
                      Text(
                        "${widget.userInfo.likes}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      )
                    ]
                  ),
                )
              ),
              SizedBox(height: _iconSpace * 1.25),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: NetworkImage(widget.userInfo.pic!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all( Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
              ),
            ],
          )
        )
      );
  }
}


