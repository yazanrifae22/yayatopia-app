import 'package:yayatopia/model/picks/pick.dart';

class YayaTopPicksSuccessResponse
{
  late int count;
  late int previous;
  late int next;
  late List<Pick> picks;
  YayaTopPicksSuccessResponse.fromJson(Map<String,dynamic> map)
  {
    this.count=map['count'];
    // this.next=map['next'];
    // this.previous=map['previous'];
    this.picks=(map['results'] as List).map((e) =>Pick.fromJson(e) ).toList();
  }
}