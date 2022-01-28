import 'review_item.dart';
import 'ship_addr_item.dart';
import 'trans_item.dart';
import 'block_item.dart';
import 'billing_item.dart';
import 'comment_item.dart';
import 'shop_item.dart';
import 'follow_item.dart';
import 'history_item.dart';
import 'goods_item.dart';
import 'list_item.dart';

class UserItem {
  String? id;
  int   ? status;
  String? nickname;
  String? password;

  String? name;
  String? nameEx;
  String? birth;
  String? email;
  String? phone;
  int   ? gender;

  String? pic;
  String? picBack;
  String? message;    // 소개

  String? pushId;
  String? token;      // connection check token..

  int   ? likes;
  int   ? comments;

  Map<String, HistoryItem>?     historyData;
  Map<String, ShopItem>?        storeData; // 샵정보 목록..  user > shop > goods
  Map<String, GoodsItem>?       goodsData; // 상품 목록..

  Map<String, String>?          optionData;     // 옵션 목록.. pushOn, autoPlay,
  Map<String, FollowItem>?      followingData;  // 팔로잉 목록..
  Map<String, FollowItem>?      followerData;   // 팔로워 목록..

  Map<String, CommentItem>?     commentData;  // 코맨트 목록..
  Map<String, ReviewItem>?      reviewData;   // 리뷰 목록..

  Map<String, BlockItem>?       blockData;    // 차단/신고 목록..
  Map<String, BillingItem>?     billingData;  // 결제수단 목록..
  Map<String, TransItem>?       transData;    // 배송정보 목록..
  Map<String, ShipAddrItem>?    shipAddrData;    // 배송정보 목록..

  Map<String, ListItem>?        socialData;   // 소셜 목록..
  Map<String, ListItem>?        couponData;   // 쿠폰 목록..

  List<String>?    categoryData;    // 선호 카테고리 목록..
  List<String>?    jobData;         // 직업 카테고리 목록..
  List<ListItem>?  goodsShowData;   // 최근 본 상품 목록..

  DateTime? loginTime;
  DateTime? logoutTime;
  DateTime? createTime;
  DateTime? deleteTime;

  UserItem(
      this.id,
      this.status,
      this.nickname,
      {
        this.password,

        this.name,
        this.nameEx,
        this.birth,
        this.email,
        this.phone,
        this.gender,

        this.pic,
        this.picBack,
        this.message,

        this.pushId,
        this.token,
        this.likes,

        this.comments,
        this.reviewData,

        this.historyData,
        this.storeData,
        this.goodsData,

        this.optionData,
        this.followingData,
        this.followerData,

        this.commentData,
        this.socialData,

        this.blockData,
        this.billingData,
        this.transData,

        this.categoryData,
        this.jobData,

        this.loginTime,
        this.logoutTime,
        this.createTime,
        this.deleteTime,
      });

  UserItem.fromJson(Map<dynamic, dynamic> json) {
    try {
      id        = json['id']!;
      status    = int.parse(json['status'].toString());
      nickname  = json['nickname']!;
      password  = json['password']!;

      name      = json['name']!;
      nameEx    = json['nameEx']!;
      birth     = json['birth']!;
      email     = json['email']!;
      phone     = json['phone']!;
      gender    = json['gender']!;

      pic       = json['pic']!;
      picBack   = json['picBack']!;
      message   = json['message']!;

      pushId    = json['pushId']!;
      token     = json['token']!;
      likes     = int.parse(json['likes'].toString());
      comments  = int.parse(json['comments'].toString());

      historyData   = {};
      storeData     = {};
      goodsData     = {};
      optionData    = {};

      followingData = {};
      followerData  = {};

      commentData   = {};
      socialData    = {};
      blockData     = {};
      billingData   = {};

      categoryData  = [];
      jobData       = [];

      for (var item in json['historyData']!) {
        var itemId = item['id'].toString();
        historyData![itemId] = HistoryItem.fromJson(item);
      }

      for (var item in json['storeData']!) {
        var itemId = item['id'].toString();
        storeData![itemId] ??= item['value']!;
      }

      for (var item in json['goodsData']!) {
        var itemId = item['id'].toString();
        goodsData![itemId] = GoodsItem.fromJson(item);
      }

      for (var item in json['optionData']!) {
        var itemId = item['id'].toString();
        optionData![itemId] ??= item['value']!;
      }

      for (var item in json['followingData']!) {
        var itemId = item['id'].toString();
        followingData![itemId] = FollowItem.fromJson(item);
      }

      for (var item in json['followerData']!) {
        var itemId = item['id'].toString();
        followerData![itemId] = FollowItem.fromJson(item);
      }

      for (var item in json['commentData']!) {
        var itemId = item['id'].toString();
        commentData![itemId] = CommentItem.fromJson(item);
      }

      for (var item in json['reviewData']!) {
        var itemId = item['id'].toString();
        reviewData![itemId] = ReviewItem.fromJson(item);
      }

      for (var item in json['blockData']!) {
        var itemId = item['id'].toString();
        blockData![itemId] = BlockItem.fromJson(item);
      }

      for (var item in json['billingData']!) {
        var itemId = item['id'].toString();
        billingData![itemId] = BillingItem.fromJson(item);
      }

      for (var item in json['transData']!) {
        var itemId = item['id'].toString();
        transData![itemId] = TransItem.fromJson(item);
      }

      for (var item in json['shipAddrData']!) {
        var itemId = item['id'].toString();
        shipAddrData![itemId] = ShipAddrItem.fromJson(item);
      }

      for (var item in json['socialData']!) {
        var itemId = item['id'].toString();
        socialData![itemId] = ListItem.fromJson(item);
      }

      for (var item in json['couponData']!) {
        var itemId = item['id'].toString();
        couponData![itemId] = ListItem.fromJson(item);
      }

      for (var item in json['categoryData']!) {
        categoryData!.add(item.toString());
      }

      for (var item in json['jobData']!) {
        jobData!.add(item.toString());
      }

      loginTime     = DateTime.parse(json['loginTime' ].toString());
      logoutTime    = DateTime.parse(json['logoutTime'].toString());
      createTime    = DateTime.parse(json['createTime'].toString());
      deleteTime    = DateTime.parse(json['deleteTime'].toString());

    } catch(e) {
      print("--> UserItem error : $e");
    }

    // optionData = json['option'],
    // followingData = json['following'],
    // followerData = json['follower'],
    // commentData = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id']            = id;
    data['status']        = status;
    data['nickname']      = nickname;

    data['name']          = name;
    data['nameEx']        = nameEx;
    data['birth']         = birth;
    data['email']         = email;
    data['phone']         = phone;
    data['gender']        = gender;

    data['pic']           = pic;
    data['picBack']       = picBack;
    data['message']       = message;

    data['pushId']        = pushId;
    data['token']         = token;
    data['likes']         = likes;
    data['comments']      = comments;

    data['history']       = historyData;
    data['store']         = goodsData;
    data['storeData']     = storeData;

    data['following']     = followingData;
    data['follower']      = followerData;
    data['comments']      = commentData;
    data['categoryData']  = categoryData;
    data['socialData']    = socialData;
    data['blockData']     = blockData;
    data['billingData']   = billingData;

    data['option']        = optionData;
    data['jobData']       = jobData;

    return data;
  }
}
