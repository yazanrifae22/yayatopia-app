import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share/share.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: getProportionateScreenWidth(320),
        height: getProportionateScreenHeight(350),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: getProportionateScreenWidth(320),
                  height: getProportionateScreenHeight(320) / 2.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Image(
                      image: AssetImage("assets/0.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    top: getProportionateScreenHeight(17),
                    left: getProportionateScreenWidth(17),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      width: getProportionateScreenWidth(90),
                      height: getProportionateScreenHeight(34),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cake,
                              color: AppColors.icongray,
                              size: getProportionateScreenWidth(16),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(7))),
                            Text("6-10y",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: AppColors.black3,
                                        fontSize:
                                            getProportionateScreenWidth(13)))
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  bottom: getProportionateScreenHeight(-20),
                  right: getProportionateScreenWidth(26),
                  child: CircleAvatar(
                    backgroundColor: HexColor("#eeeeee"),
                    radius: getProportionateScreenHeight(31),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: getProportionateScreenHeight(30),
                      child: IconButton(
                        icon: Icon(
                          Icons.share,
                          size: getProportionateScreenWidth(25),
                        ),
                        color: Colors.black,
                        onPressed: () {
                          Share.share("hello");
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: getProportionateScreenHeight(-20),
                  left: getProportionateScreenWidth(26),
                  child: CircleAvatar(
                    backgroundColor: HexColor("#eeeeee"),
                    radius: getProportionateScreenHeight(31),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: getProportionateScreenHeight(30),
                      child: IconButton(
                        icon: Icon(
                          Icons.timer,
                          size: getProportionateScreenWidth(25),
                        ),
                        color: AppColors.orange,
                        onPressed: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(28)),
              child: Container(
                width: getProportionateScreenWidth(280),
                child: FittedBox(
                  child: Text(
                      "iD Tech’s Spring Edition Block \nParty on Roblox",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: AppColors.black3)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  top: getProportionateScreenHeight(20)),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  Icons.watch_later,
                  color: Colors.grey,
                  size: getProportionateScreenWidth(13),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(10))),
                Text(
                  "Saturday, 25 Sep 2021, 12:30 pm",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.black3,
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: getProportionateScreenHeight(12))),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: getProportionateScreenWidth(13),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(10))),
                  Text(
                    "1024 Elm Street, Los Angeles",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColors.black3,
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: getProportionateScreenHeight(12))),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                  Icons.language,
                  color: Colors.grey,
                  size: getProportionateScreenWidth(13),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(10))),
                Text(
                  "English, Italian",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.black3,
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
