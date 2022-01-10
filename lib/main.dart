import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:oman_001/screens/feed_viewmodel.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:oman_001/main_home/main_home.dart';
import 'package:oman_001/main_my/main_myprofile.dart';
import 'package:oman_001/main_oman/main_oman.dart';
import 'package:oman_001/main_search/main_search.dart';
import 'package:oman_001/main_store/main_store.dart';

import 'data/home_item.dart';
import 'data/videos_firebase.dart';

GetIt locator = GetIt.instance;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
  ));

  WidgetsFlutterBinding.ensureInitialized();

  //   if (Firebase.apps.isEmpty) {
  //   FirebaseApp app = await Firebase.initializeApp(
  //     name: "[DEFAULT]",
  //     options: FirebaseOptions(
  //         apiKey: "AIzaSyBhuFu_G7rtnyhxS0d1U5IuP6mPlmmUKPI",
  //         authDomain: "oman-01.firebaseapp.com",
  //         projectId: "oman-01",
  //         storageBucket: "oman-main-data-0000",
  //         messagingSenderId: "787744327503",
  //         appId: "1:787744327503:web:3dd24be27582e1c742273a",
  //         measurementId: "G-8FWH38YHNY"
  //     ),
  //   );
  //   print('--> Initialized : $app');
  // } else {
  //   FirebaseApp app = Firebase.app("[DEFAULT]");
  //   print('--> FirebaseApp : $app');
  // }

  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(
  //     name: "OMan-01",
  //     options: FirebaseOptions(
  //         apiKey: "AIzaSyBhuFu_G7rtnyhxS0d1U5IuP6mPlmmUKPI",
  //         authDomain: "oman-01.firebaseapp.com",
  //         projectId: "oman-01",
  //         storageBucket: "oman-main-data-0000",
  //         messagingSenderId: "787744327503",
  //         appId: "1:787744327503:web:3dd24be27582e1c742273a",
  //         measurementId: "G-8FWH38YHNY"
  //     ),
  //   );
  // } else {
  //   Firebase.app();
  // }

  setUpLocator();
  runApp(const MyApp());
}

void setUpLocator()
{
  // locator.registerLazySingleton<FeedViewModel>(() => FeedViewModel());
  locator.registerSingleton<FeedViewModel>(FeedViewModel());
}

BuildContext? testContext;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Make Fullscreen Mode..
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

    return MaterialApp(
      title: 'Example project',
      theme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        fontFamily: 'NotoSans',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 11.0),
        ),
      ),
      home: MainMenu(),
      // initialRoute: '/',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/first': (context) => MainSearchScreen(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/second': (context) => MainOmanScreen(),
      // },
    );
  }
}

// ----------------------------------------- Main denu ----------------------------------------- //

class MainMenu extends StatefulWidget {
  final BuildContext? menuScreenContext;
  const MainMenu({Key? key, this.menuScreenContext}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MainMenu> {
  PersistentTabController? _controller;
  bool _hideNavBar = false;
  List<int>   _badgeCounts = List<int>.generate(5, (index) => index);
  List<bool>  _badgeShows  = List<bool>.generate(5, (index) => true);

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      MainHomeScreen(),
      MainSearchScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainOmanScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainStoreScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainMyScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      )
    ];
  }

  List<CustomNavigationBarItem> _navBarsItems() {
    return [
      CustomNavigationBarItem(
        icon: _controller!.index == 0 ? Image.asset("assets/ui/main_menu/Home_1.png") : Opacity(opacity: 0.5, child: Image.asset("assets/ui/main_menu/Home_0.png")),
        badgeCount: _badgeCounts[0],
        showBadge: _badgeShows[0],
      ),
      CustomNavigationBarItem(
        icon: _controller!.index == 1 ? Image.asset("assets/ui/main_menu/Search_1.png") : Opacity(opacity: 0.5, child: Image.asset("assets/ui/main_menu/Search_0.png")),
        badgeCount: _badgeCounts[1],
        showBadge: _badgeShows[1],
      ),
      CustomNavigationBarItem(
        icon: _controller!.index == 2 ? Image.asset("assets/ui/main_menu/Oman_1.png") : Opacity(opacity: 0.5, child: Image.asset("assets/ui/main_menu/Oman_0.png")),
        badgeCount: _badgeCounts[2],
        showBadge: _badgeShows[2],
      ),
      CustomNavigationBarItem(
        icon: _controller!.index == 3 ? Image.asset("assets/ui/main_menu/Shop_1.png") : Opacity(opacity: 0.5, child: Image.asset("assets/ui/main_menu/Shop_0.png")),
        badgeCount: _badgeCounts[3],
        showBadge: _badgeShows[3],
      ),
      CustomNavigationBarItem(
        icon: _controller!.index == 4 ? Image.asset("assets/ui/main_menu/My_1.png") : Opacity(opacity: 0.5, child: Image.asset("assets/ui/main_menu/My_0.png")),
        badgeCount: _badgeCounts[4],
        showBadge: _badgeShows[4],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MainAppBar(_controller!.index),
        drawer: Drawer(
          child: SizedBox(
              height: 500,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('This is the Drawer'),
                  ],
                ),
              )
          ),
        ),
        body: PersistentTabView.custom(
          context,
          controller: _controller,
          screens: _buildScreens(),
          confineInSafeArea: true,
          itemCount: 5,
          handleAndroidBackButtonPress: true,
          stateManagement: true,
          hideNavigationBar: _hideNavBar,
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          customWidget: CustomNavigationBar(
            iconSize: 30.0,
            selectedColor: Colors.white,
            strokeColor: Color(0x30040307),
            unSelectedColor: Colors.grey,
            backgroundColor: Colors.black,
            items: _navBarsItems(),
            currentIndex: _controller!.index,
            onTap: (index) {
              setState(() {
                _controller!.index = index;
              });
            },
          ),
        )
      ),
    );
  }
}

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  var _currentMenu;
  final _height = 60.0;
  final _iconSize = 40.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  MainAppBar(this._currentMenu, { Key? key}) : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: _height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.black.withOpacity(0),
          child: Row(
            children: <Widget> [
              SizedBox(
                height: _height,
                width: _height,
                child: IconButton(
                  icon: Image.asset("assets/ui/main_top/Logo_00.png"),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                )
              ),
              Expanded(
                child: Text(
                  ""
                )
              ),
              Row(
                children: <Widget> [
                  SizedBox(
                    height: _iconSize,
                    width: _iconSize,
                    child: IconButton(
                      icon: Image.asset("assets/ui/main_top/Contents.png"),
                      onPressed: () {
                      },
                    )
                  ),
                  SizedBox(width: 5),
                  SizedBox(
                      height: _iconSize,
                      width: _iconSize,
                      child: IconButton(
                        icon: Image.asset("assets/ui/main_top/Message.png"),
                        onPressed: () {
                        },
                      )
                  ),
                  SizedBox(width: 5),
                  SizedBox(
                      height: _iconSize,
                      width: _iconSize,
                      child: IconButton(
                        icon: Image.asset("assets/ui/main_top/Shopping.png"),
                        onPressed: () {
                        },
                      )
                  ),
                ],
              ),
            ],
          )
        )
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final int _currentMenu;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  CustomAppBar(this._currentMenu, { Key? key}) : preferredSize = Size.fromHeight(160.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: 160.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: Center(
                child: Text(
                  "AppBar",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            Positioned(
              top: 80.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

