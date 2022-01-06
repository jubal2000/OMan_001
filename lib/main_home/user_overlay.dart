import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class UserOverlayScreen extends StatefulWidget {
  final VideoPlayerController? controller;
  final Function? onScreenClosed;

  const UserOverlayScreen({
    Key? key,
    this.controller,
    this.onScreenClosed
  }) : super(key: key);

  @override
  UserOverlayState createState() => UserOverlayState();
}

class UserOverlayState extends State<UserOverlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0, right: 30),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        color: Colors.yellow.withOpacity(0.9),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                },
                child: Icon(
                  Icons.play_arrow,
                )
              ),
              SizedBox(width: 5),
              ElevatedButton(
                  onPressed: () {
                  },
                  child: Icon(
                    Icons.play_arrow,
                  )
              ),
            ],
          )
        )
      );
  }
}


