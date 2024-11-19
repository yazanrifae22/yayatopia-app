import 'package:yayatopia/model/activity_detail/activity_detail.dart';

class YayaTopActivitySuccessResponse {
  late Activity activity;

  YayaTopActivitySuccessResponse.fromJson(Map<String, dynamic> map) {
    this.activity = Activity.fromJson(map['activity']);
  }
}
