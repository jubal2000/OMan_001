import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'package:oman_001/main_home/main_home.dart';
import 'package:oman_001/main_my/main_myprofile.dart';
import 'package:oman_001/main_oman/main_oman.dart';
import 'package:oman_001/main_search/main_search.dart';
import 'package:oman_001/main_store/main_store.dart';

import 'data/app_data.dart';
import 'main_top.dart';

GetIt locator = GetIt.instance;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
  ));

  WidgetsFlutterBinding.ensureInitialized();

  AppData.isMainPlay = AppData.isAutoPlay;

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

  // setUpLocator();
  runApp(const MyApp());
}

// void setUpLocator()
// {
//   // locator.registerLazySingleton<FeedViewModel>(() => FeedViewModel());
//   locator.registerSingleton<FeedViewModel>(FeedViewModel());
// }

BuildContext? testContext;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Make Fullscreen Mode..
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OMan v0.0.1',
      theme: AppData.MainTheme,
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
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  TabController? _controller;
  final List<int>   _badgeCounts = List<int>.generate(5, (index) => index);
  final List<bool>  _badgeShows  = List<bool>.generate(5, (index) => true);
  final _iconSize = 20.0;
  int _currentMenu = 0;

  final List<List<String>> _iconList = [
    ["assets/ui/main_menu/Home_0.png"   ,"assets/ui/main_menu/Home_1.png"   ],
    ["assets/ui/main_menu/Search_0.png" ,"assets/ui/main_menu/Search_1.png" ],
    ["assets/ui/main_menu/Oman_0.png"   ,"assets/ui/main_menu/Oman_1.png"   ],
    ["assets/ui/main_menu/Shop_0.png"   ,"assets/ui/main_menu/Shop_1.png"   ],
    ["assets/ui/main_menu/My_0.png"     ,"assets/ui/main_menu/My_1.png"     ],
  ];

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _buildScreens = [
    MainHomeScreen(),
    MainSearchScreen(),
    MainOmanScreen(),
    MainStoreScreen(),
    MainMyScreen()
  ];

  List<Tab> _navBarsItems() {
    List<Tab> _list = [];
    for (var i=0; i<_iconList.length; i++) {
      _list.add( Tab(
          child: Badge(
            position: BadgePosition(top:-15.0, start:12.0),
            badgeContent: Text(_badgeCounts[i].toString()),
            showBadge: _badgeShows[i],
            child: SizedBox(
                width:  _iconSize,
                height: _iconSize,
                child: _currentMenu == i ? Image.asset(_iconList[i][1]) : Opacity(opacity: 0.5, child: Image.asset(_iconList[i][0]))
            ),
          )
        )
      );
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Stack(
                children: [
                  DefaultTabController(
                      length: _buildScreens.length,
                      child: Scaffold(
                        backgroundColor: Colors.black,
                        body: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: _buildScreens,
                        ),
                        bottomNavigationBar: TabBar(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(width: 2.0, color: Colors.purple),
                                insets: EdgeInsets.symmetric(horizontal:20.0)
                            ),
                            onTap: (index) {
                              setState(() {
                                _currentMenu = index;
                              });
                            },
                            controller: _controller,
                            tabs: _navBarsItems()
                        ),
                      )
                  ),
                  MainAppBar(_buildScreens, _currentMenu),
                ]
            )
        )
    );
  }
}

