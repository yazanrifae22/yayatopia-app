import 'package:dio/dio.dart';
import 'package:yayatopia/core/dio_base.dart';
import 'package:yayatopia/core/exceptions/exception.dart';
import 'package:yayatopia/messages/pick/yaya_top_picks_success_response.dart';
import 'package:yayatopia/model/picks/pick.dart';

class TopPicksRepository {
  Future<List<Pick>> getYayaTopPicks() async {
    try {
      Response r = await DioBase.instance.get('/activities/featured');

      return YayaTopPicksSuccessResponse.fromJson(r.data).picks;
    } on DioError catch (_) {
      throw GetFailedException();
    }
  }
}
