import 'package:intl/intl.dart';

class Pick
{
  late int activityId;
  late String title;
  late String startTime;
  late String startTimeEastern;
  late String timeZone;
  late String imageurl;
  late String activityWebUrl;
  late bool active;
  late String nextDate;
  late int nextDateNull;
  late String viewDate;
  Pick.fromJson(Map<String,dynamic> map)
  {
    this.activityId=map['activity_id'];
    this.title=map['title'];
    this.startTime=map['start_time'];
    this.startTimeEastern=map['start_time_eastern'];
    this.timeZone=map['time_zone'];
    this.imageurl=map['image'];
    this.activityWebUrl=map['activity_web_url'];
    this.active=map['active'];
    this.nextDate=map['next_date'];
    this.nextDateNull=map['next_date_null'];
    this.viewDate= DateFormat('MMM dd @ HH:MM a').format(DateTime.parse(nextDate+" "+startTimeEastern));
  }
  

}