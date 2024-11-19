import 'package:yayatopia/model/activity_detail/activity_detail.dart';

class YayaTopActivityImagesSuccessResponse {
  late int count;
  late int next;
  late int previous;
  late List<Results> results;
  YayaTopActivityImagesSuccessResponse.fromJson(Map<String, dynamic> map) {
    this.count = map['count'];
    // this.next=map['next'];
    // this.previous=map['previous'];
    this.results =
        (map['results'] as List).map((e) => Results.fromJson(e)).toList();
  }
}
