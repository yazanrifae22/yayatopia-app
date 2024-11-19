import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yayatopia/blocs/home/activities/cubit/activities_cubit.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:photo_view/photo_view.dart';
import 'package:yayatopia/model/activity_detail/activity_detail.dart';

// ignore: must_be_immutable
class ActivityPage extends StatefulWidget {
  bool isLove = false;
  int id;
  ActivityPage(this.id, {Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late Activity activity;
  List<String> weekDays = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ActivitiesCubit>(context).getYayaTopActivities(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildWidget());
  }

  Widget buildWidget() {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
        builder: (context, state) {
      if (state is ActivitiesLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.bluebuttons,
          ),
        );
      } else if (state is ActivitiesError)
        return Center(
          child: Text("Network Connection Error"),
        );
      else if (state is ActivitiesFectched) {
        weekDays = ["Reapeats :"];
        return Column(children: [
          Container(
            width: width,
            height: hight * 0.33,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Carousel(
                  images: state.images
                      .map(
                        (e) => Hero(
                          tag: e.id,
                          child: Image(
                            image: NetworkImage(e.imageThumbPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                  autoplay: false,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: getProportionateScreenWidth(5),
                  onImageTap: (i) {
                    if (state.images.isNotEmpty) {
                      print(i);
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Scaffold(
                          body: Center(
                            child: PhotoView(
                              heroAttributes: PhotoViewHeroAttributes(tag: i),
                              minScale: PhotoViewComputedScale.contained * 0.8,
                              maxScale: PhotoViewComputedScale.covered * 0.99,
                              loadingBuilder: (context, event) =>
                                  CircularProgressIndicator(
                                      color: AppColors.bluebuttons),
                              backgroundDecoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor),
                              imageProvider:
                                  NetworkImage(state.images[i].image),
                            ),
                          ),
                        );
                      }));
                    } else {}
                  },
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomCenter,
                  dotVerticalPadding: 10.0,
                  indicatorBgPadding: 7.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: hight * 0.07,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: hight * 0.031,
                      child: IconButton(
                        icon: Icon(Icons.share),
                        color: Colors.blueGrey,
                        onPressed: () {
                          Share.share("hello");
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: hight * 0.031,
                      child: IconButton(
                        icon: (widget.isLove == true)
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            widget.isLove = (widget.isLove) ? false : true;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(200),
                          child: Column(children: [
                            Text(state.activity.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontSize:
                                            getProportionateScreenWidth(18))),
                          ]),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                right: getProportionateScreenWidth(25))),
                        Expanded(
                          child: Text(
                              state.activity.currency.isoCode +
                                  ' ' +
                                  state.activity.currency.symbol +
                                  state.activity.price +
                                  '-' +
                                  state.activity.currency.symbol +
                                  state.activity.priceMax,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: getProportionateScreenWidth(13),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black2)),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: hight * 0.005)),
                    Text(state.activity.subTitle,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: getProportionateScreenWidth(13))),
                    Padding(padding: EdgeInsets.only(top: hight * 0.007)),
                    Wrap(
                      runSpacing: getProportionateScreenHeight(9),
                      spacing: getProportionateScreenWidth(10),
                      children: state.activity.categories
                          .map((e) => ElevatedButton(
                                onPressed: null,
                                child: Text(e.friendly,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    10))),
                                style: ElevatedButton.styleFrom().copyWith(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)))),
                              ))
                          .toList(),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(9))),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.watch_later,
                            color: Colors.grey,
                            size: getProportionateScreenWidth(13),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(5))),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text(
                                      state.activity.nextDate != "null"
                                          ? state.activity.nextDate + ', '
                                          : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: AppColors.black3,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      state.activity.startTimeEastern != "null"
                                          ? 'Start : ' +
                                              state.activity.startTimeEastern +
                                              ', '
                                          : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: AppColors.black3,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      state.activity.endTimeEastern != "null"
                                          ? 'End : ' +
                                              state.activity.endTimeEastern +
                                              ' '
                                          : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: AppColors.black3,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      state.activity.timeZone != "null"
                                          ? '(' + state.activity.timeZone + ')'
                                          : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: AppColors.black3,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12),
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              getProportionateScreenHeight(4))),
                                  Wrap(
                                    children: numToDays(state
                                            .activity.recurringDays
                                            .split(','))
                                        .map((e) => Text(
                                              e + ' ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: AppColors.black2,
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              11),
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ))
                                        .toList(),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              getProportionateScreenHeight(3))),
                                  Text(
                                    state.activity.endDate != "null"
                                        ? 'Ends : ' + state.activity.endDate
                                        : '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: AppColors.black2,
                                            fontSize:
                                                getProportionateScreenWidth(11),
                                            fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ]),
                    Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(9))),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: getProportionateScreenWidth(13),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(5))),
                        Text(
                          state.activity.suiteNumber.toString() != "null"
                              ? state.activity.suiteNumber.toString() + ', '
                              : '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: AppColors.black3,
                                  fontSize: getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.activity.streetAddress.toString() != "null"
                              ? state.activity.streetAddress.toString() + ', '
                              : '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: AppColors.black3,
                                  fontSize: getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.activity.additionalStreetAddress.toString() !=
                                  "null"
                              ? state.activity.additionalStreetAddress
                                      .toString() +
                                  ', '
                              : '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: AppColors.black3,
                                  fontSize: getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.activity.city.toString() != "null"
                              ? state.activity.city.toString() + ', '
                              : '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: AppColors.black3,
                                  fontSize: getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.activity.province.toString() != "null"
                              ? state.activity.province.toString() + ', '
                              : '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: AppColors.black3,
                                  fontSize: getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.activity.postalCode.toString() != "null"
                              ? state.activity.postalCode.toString()
                              : '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: AppColors.black3,
                                  fontSize: getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(9))),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.language,
                            color: Colors.grey,
                            size: getProportionateScreenWidth(13),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(5))),
                          Wrap(
                            children: state.activity.languages
                                .map((e) => Text(
                                      e.friendly + ', ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: AppColors.black3,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12),
                                              fontWeight: FontWeight.bold),
                                    ))
                                .toList(),
                          )
                        ]),
                    Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(9))),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.activity.minAge.toString() != "null"
                              ? Icon(
                                  Icons.cake,
                                  color: Colors.grey,
                                  size: getProportionateScreenWidth(13),
                                )
                              : Text(''),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(5))),
                          Text(
                            state.activity.minAge.toString() != "null"
                                ? state.activity.minAge.toString() + ' - '
                                : '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppColors.black3,
                                    fontSize: getProportionateScreenWidth(12),
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            state.activity.maxAge.toString() != "null"
                                ? state.activity.maxAge.toString() +
                                    ' year olds '
                                : '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppColors.black3,
                                    fontSize: getProportionateScreenWidth(12),
                                    fontWeight: FontWeight.bold),
                          )
                        ]),
                    Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(9))),
                    Wrap(
                      spacing: getProportionateScreenWidth(10),
                      children: state.activity.tags
                          .map((e) => ElevatedButton(
                                onPressed: null,
                                child: Text(e.friendly,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: AppColors.black2,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    10))),
                                style: ElevatedButton.styleFrom().copyWith(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(Size(
                                            getProportionateScreenWidth(80),
                                            getProportionateScreenHeight(35))),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.gray),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)))),
                              ))
                          .toList(),
                    ),
                    Padding(padding: EdgeInsets.only(top: hight * 0.007)),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom().copyWith(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(width * 0.55, hight * 0.06)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                )),
                            onPressed: () {},
                            child: Text(
                              "Buy Tickets",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: AppColors.white,
                                      fontSize:
                                          getProportionateScreenWidth(13)),
                            )),
                        Padding(padding: EdgeInsets.only(left: width * 0.04)),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom().copyWith(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(width * 0.3, hight * 0.06)),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                                (Set<MaterialState> states) {
                              return BorderSide(
                                  color: AppColors.bluebuttons, width: 2);
                            }),
                          ),
                          onPressed: () =>
                              _launchURL(state.activity.externalUrl),
                          child: Text(
                            "Visit Activity",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: AppColors.bluebuttons,
                                    fontSize: getProportionateScreenWidth(13)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: hight * 0.03)),
              Center(
                child: Container(
                  width: width * 0.85,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: hight * 0.03, bottom: hight * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: getProportionateScreenWidth(13),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                    left: width * 0.015,
                                  )),
                                  Text(
                                    state.activity.creatorName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    12)),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 10)),
                              Text(
                                state.activity.organization.toString() != "null"
                                    ? state.activity.organization.toString()
                                    : '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: AppColors.bluebuttons,
                                        fontSize:
                                            getProportionateScreenWidth(14)),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 10)),
                              Row(children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Contact",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    12)),
                                  ),
                                  style: ElevatedButton.styleFrom().copyWith(
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            Size(width * 0.25, hight * 0.045)),
                                  ),
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom().copyWith(
                                      minimumSize: MaterialStateProperty.all<
                                              Size>(
                                          Size(hight * 0.045, hight * 0.045)),
                                      shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.zero),
                                      side: MaterialStateProperty.resolveWith<
                                              BorderSide>(
                                          (Set<MaterialState> states) {
                                        return BorderSide(
                                            color: AppColors.black, width: 1);
                                      }),
                                    ),
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.flag,
                                      color: Colors.black,
                                      size: getProportionateScreenWidth(15),
                                    ))
                              ]),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.gray,
                                ),
                                width: width * 0.11,
                                height: width * 0.11,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: hight * 0.03)),
                    Container(
                      padding: EdgeInsets.all(hight * 0.03),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppColors.black2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(13)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: getProportionateScreenWidth(8))),
                          Text(
                            state.activity.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    height: getProportionateScreenHeight(1.7),
                                    fontSize: getProportionateScreenWidth(12)),
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: hight * 0.03)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(hight * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Details",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppColors.black2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(13)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: getProportionateScreenWidth(8))),
                          Text(
                            state.activity.detailedDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    height: getProportionateScreenHeight(1.7),
                                    fontSize: getProportionateScreenWidth(12)),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ))
        ]);
      }

      return SizedBox();
    });
  }

  List<String> numToDays(List<String> numbers) {
    for (var c in numbers) {
      switch (c) {
        case "1":
          weekDays.add("Monday,");
          break;
        case "2":
          weekDays.add("Tuesday,");
          break;
        case "3":
          weekDays.add("Wednesday,");
          break;
        case "4":
          weekDays.add("Thursday,");
          break;
        case "5":
          weekDays.add("Friday,");
          break;
        case "6":
          weekDays.add("Saturday,");
          break;
        case "7":
          weekDays.add("Sunday,");
          break;
        default:
          break;
      }
    }
    return weekDays;
  }

  void _launchURL(String externalUrl) async => await canLaunch(externalUrl)
      ? await launch(externalUrl)
      : throw 'Could not launch $externalUrl';
}
