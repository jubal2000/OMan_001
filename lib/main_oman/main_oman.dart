import 'package:flutter/material.dart';

class MainOmanScreen extends StatelessWidget {
  final BuildContext? menuScreenContext;
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;

  const MainOmanScreen(
      { Key? key,
        this.menuScreenContext,
        this.onScreenHideButtonPressed,
        this.hideStatus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(
        child: Text("MainOmanScreen",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))
    );
  }

}

