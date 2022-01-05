import 'package:flutter/material.dart';

class MainStoreScreen extends StatelessWidget {
  final BuildContext? menuScreenContext;
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;

  const MainStoreScreen(
      { Key? key,
        this.menuScreenContext,
        this.onScreenHideButtonPressed,
        this.hideStatus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(
        child: Text("MainStoreScreen",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))
    );
  }

}

