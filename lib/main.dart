import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import 'package:oman_001/main_home/main_home.dart';
import 'package:oman_001/main_my/main_myprofile.dart';
import 'package:oman_001/main_my/setup_screen.dart';
import 'package:oman_001/main_oman/main_oman.dart';
import 'package:oman_001/main_search/main_search.dart';
import 'package:oman_001/main_store/main_store.dart';
import 'package:oman_001/utils/login_utils.dart';
import 'package:oman_001/utils/network_utils.dart';
import 'package:oman_001/utils/utils.dart';
import 'package:oman_001/widgets/search_widget.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'data/user_item.dart';
import 'firebase_config.dart';

import 'data/app_data.dart';
import 'main_top.dart';

GetIt locator = GetIt.instance;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
  ));

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  // for localhost Dev..
  FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);

  // try {
  //   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: "barry.allen@example.com",
  //       password: "SuperSecretPassword!"
  //   );
  // } on FirebaseAuthException catch (e) {
  //   if (e.code == 'weak-password') {
  //     print('The password provided is too weak.');
  //   } else if (e.code == 'email-already-in-use') {
  //     print('The account already exists for that email.');
  //   }
  // } catch (e) {
  //   print(e);
  // }

  // signInWithGoogle().then((signInInfo) {
  //   print('--> signInInfo : ${signInInfo}');
  // });

  AppData.isMainPlay = AppData.isAutoPlay;

  getStartInfo(AppData.deviceType).then((value) => {
    print('--> serverMain : ${AppData.startInfo!.serverMain}'),
    runApp(const MyApp())
  });
}

// void setUpLocator()
// {
//   // locator.registerLazySingleton<FeedViewModel>(() => FeedViewModel());
//   locator.registerSingleton<FeedViewModel>(FeedViewModel());
// }

BuildContext? testContext;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Future<UserItem>? _calculationLogin;
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();
    // get user login..
    FirebaseAuth.instance
    .authStateChanges()
    .listen((user) {
      setState(() {
        if (user == null) {
          if (AppData.userInfo != null) {
            print('--> User is currently signed out!');
            AppData.isMainDataReady = false;
            AppData.userInfo = null;
            _calculationLogin = null;
            restartApp();
          }
        } else {
            AppData.loginUUID = user.uid;
            print('--> User is signed in! : ${AppData.loginUUID} / ${user.email}');
            _calculationLogin = getUserInfo(AppData.loginUUID);
        }
      });
    });
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Make Fullscreen Mode..
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

    return KeyedSubtree(
        key: key,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OMan v0.0.1',
          theme: MainTheme,
          // home: MainMenu()
          home: FutureBuilder(
            future: _calculationLogin,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print('--> snapshot : ${snapshot.hasData}');
              if (snapshot.hasData) {
                return MainMenu();
              } else {
                if (AppData.userInfo == null) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("OMAN Login"),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //해당 부분은 email의 유무에 따라 로그인이 됐는지 안됐는지를 판단하고 해당 로그인이 제대로 됐다면
                          //구글의 프로필 이미지, 닉네임, 이메일을 가져와 출력을 시켜줄것이다.
                          // AppData.userInfo!.email!.isEmpty
                          //     ? Container()
                          //     : Column(
                          //   children: <Widget>[
                          //     Image.network(AppData.userInfo!.pic!),
                          //     Text(AppData.userInfo!.name!),
                          //     Text(AppData.userInfo!.email!),
                          //   ],
                          // ),
                          ElevatedButton(
                            onPressed: () {
                              signInWithGoogle();
                            },
                            //여기또한 이메일의 존재 여부를 통해 해당 버튼의 텍스트를 바꾸어 준다.
                            child: Container(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Icon(Icons.subdirectory_arrow_right),
                                    Text('Google Login')
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            }
          ),
      )
    );
  }
}

// Widget get checkLogin {
//   if (AppData.userInfo == null) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("OMAN Login"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             //해당 부분은 email의 유무에 따라 로그인이 됐는지 안됐는지를 판단하고 해당 로그인이 제대로 됐다면
//             //구글의 프로필 이미지, 닉네임, 이메일을 가져와 출력을 시켜줄것이다.
//             // AppData.userInfo!.email!.isEmpty
//             //     ? Container()
//             //     : Column(
//             //   children: <Widget>[
//             //     Image.network(AppData.userInfo!.pic!),
//             //     Text(AppData.userInfo!.name!),
//             //     Text(AppData.userInfo!.email!),
//             //   ],
//             // ),
//             ElevatedButton(
//               onPressed: () {
//                 signInWithGoogle();
//               },
//               //여기또한 이메일의 존재 여부를 통해 해당 버튼의 텍스트를 바꾸어 준다.
//               child: Container(
//                   width: 150,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const <Widget>[
//                       Icon(Icons.subdirectory_arrow_right),
//                       Text('Google Login')
//                     ],
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   } else {
//     return FutureBuilder(
//         future: _calculationLogin,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           // print('--> snapshot : ${snapshot.hasData}');
//           if (snapshot.hasData) {
//             return MainMenu();
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         }
//     );
//   }
// }

// var url = Uri.parse(AppData.funcGetStartInfoItem);
// var response = await http.post(
// url, body: {'name': 'doodle', 'color': 'blue'});


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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // caching images..
    for (var item in AppData.searchImageList) {
      precacheImage(AssetImage(item), context);
    }
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
      child: GestureDetector(
          onTap: () {
            setState(() {
              AppData.setSearchEnable(false);
            });
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: MainTheme,
            home: Stack(
                children: [
                  DefaultTabController(
                      length: _buildScreens.length,
                      child: Scaffold(
                        key: AppData.mainScreenKey,
                        backgroundColor: Colors.black,
                        // drawer: Drawer(
                        //   child: SetupScreen(),
                        // ),
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
        ),
      );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

