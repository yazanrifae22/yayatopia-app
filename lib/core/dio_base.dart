import 'package:dio/dio.dart';

BaseOptions _options = BaseOptions(
  baseUrl: "https://yayatopia.sakarisoft.com/app/v2/",
  contentType: 'application/json',
);

class DioBase {
  static final Dio instance = Dio(_options);
  static init() {
    instance.interceptors.add(InterceptorsWrapper(onRequest: (r, h) async {
      print("Requset: ");
      print(r.baseUrl + r.path);
      h.next(r);
    }, onResponse: (r, h) async {
      print("Success Response: ");
      print(r.data);
      h.next(r);
    }, onError: (r, h) {
      print("Error Response : ");
      print(r.error.toString());
      h.next(r);
    }));
  }
}
