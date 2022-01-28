
import 'job_item.dart';
import 'social_item.dart';
import 'category_item.dart';
import 'coupon_item.dart';

class SpecData {
  static final SpecData _singleton = SpecData._internal();

  static Map<String, CategoryItem> categoryData = {};
  static Map<String, SocialItem> socialData = {};
  static Map<String, JobItem> jobData = {};
  static Map<String, CouponItem> couponData = {};

  factory SpecData() {
    return _singleton;
  }

  SpecData._internal();
}
