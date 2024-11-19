import 'package:dio/dio.dart';
import 'package:yayatopia/core/dio_base.dart';
import 'package:yayatopia/core/exceptions/exception.dart';
import 'package:yayatopia/messages/activity/yaya_top_activityImages_success_response.dart';
import 'package:yayatopia/messages/activity/yaya_top_activity_success_response.dart';

class ActivityDetailRepository {
  Future<List<dynamic>> getYayaTopActivity(int id) async {
    try {
      Response r = await DioBase.instance.get('activity/view/$id');
      Response images = await DioBase.instance.get('activity/images/$id');
      List<dynamic> list = [];
      list.add(YayaTopActivitySuccessResponse.fromJson(r.data).activity);
      list.add(
          YayaTopActivityImagesSuccessResponse.fromJson(images.data).results);
      return list;
    } on DioError catch (_) {
      throw GetFailedException();
    }
  }
}
