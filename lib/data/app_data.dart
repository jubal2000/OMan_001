class AppData {
  static final AppData _singleton = AppData._internal();

  final int SCROLL_SPEED = 250;
  static var isMainDataReady = false;
  static var isShowPlayerInfo = true;


  factory AppData() {
    return _singleton;
  }

  AppData._internal();
}
