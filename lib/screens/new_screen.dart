import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oman_001/data/app_data.dart';
import 'package:oman_001/utils/utils.dart';

class NewScreen extends StatefulWidget {
  NewScreen({Key? key}) : super (key : key);

  @override
  State<StatefulWidget> createState() => NewScreenState();
}

class NewScreenState extends State<NewScreen> with AutomaticKeepAliveClientMixin<NewScreen> {
  final List<ListItemEx> _itemList = [
    ListItemEx("프로필 편집"),
    ListItemEx("개인정보 수정"),
    ListItemEx("비밀번호 변경"),
    ListItemEx("알림 설정"),
    ListItemEx("자동 재생 설정"),
    ListItemEx("차단/신고 내역"),
    ListItemEx("My Shop 등록"),
    ListItemEx("오만 고객센터"),
    ListItemEx("공지사항"),
    ListItemEx("FAQ"),
    ListItemEx("문의하기"),
    ListItemEx("서비스 이용 약관"),
    ListItemEx("의견 보내기"),
    ListItemEx("로그아웃"),
    ListItemEx("회원탈퇴"),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0), // here the desired height
        child: AppBar(
          primary: false,
          titleSpacing: 0,
          elevation: 1,
          title: Text('설정', style: AppData.MainTheme.textTheme.headline1),
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
        ),
      ),
      body: ListView.builder(
          itemCount: _itemList.length,
          itemBuilder: (BuildContext context, int index) {
            return _itemList[index];
          }
      ),
    );
  }
}