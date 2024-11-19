import 'package:flutter/material.dart';

import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yayatopia/pages/Main/tabs/Activity/activity_card.dart';

// ignore: camel_case_types
class activity_page extends StatefulWidget {
  final BuildContext ctx;
  final VoidCallback openFilter;
  final VoidCallback openMenu;
  final String searchText;
  const activity_page(
      {Key? key,
      required this.searchText,
      required this.ctx,
      required this.openFilter,
      required this.openMenu})
      : super(key: key);

  @override
  _activity_pageState createState() => _activity_pageState();
}

// ignore: camel_case_types
class _activity_pageState extends State<activity_page> {
  final ScrollController sliverScrollController = ScrollController();
  bool isPinned = false;

  @override
  void initState() {
    super.initState();

    sliverScrollController.addListener(() {
      if (!isPinned &&
          sliverScrollController.hasClients &&
          sliverScrollController.offset > kToolbarHeight) {
        setState(() {
          isPinned = true;
        });
      } else if (isPinned &&
          sliverScrollController.hasClients &&
          sliverScrollController.offset < kToolbarHeight) {
        setState(() {
          isPinned = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textgray,
      body: CustomScrollView(
        controller: sliverScrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: getProportionateScreenHeight(200),
            toolbarHeight: getProportionateScreenHeight(140),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(18),
                  left: getProportionateScreenWidth(32),
                  right: getProportionateScreenWidth(15)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(
                        right: getProportionateScreenWidth(10),
                        top: getProportionateScreenHeight(40)),
                    child: Container(
                      height: getProportionateScreenHeight(33),
                      child: TextFormField(
                          controller:
                              TextEditingController(text: widget.searchText),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: getProportionateScreenWidth(15)),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide:
                                      BorderSide(style: BorderStyle.none)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide:
                                      BorderSide(style: BorderStyle.none)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide:
                                      BorderSide(style: BorderStyle.none)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(11),
                                  vertical: getProportionateScreenHeight(19)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.explore +
                                  " Yayatopia",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: AppColors.black3,
                                      fontSize:
                                          getProportionateScreenWidth(10)),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.black26,
                              ))),
                    ),
                  )),
                  Padding(
                    padding:
                        EdgeInsets.only(top: getProportionateScreenHeight(40)),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        widget.openFilter();
                      },
                      child: Image.asset(
                        "assets/filtter.png",
                        width: getProportionateScreenWidth(12),
                      ),
                    ),
                  )
                ],
              ),
            ),
            title: !isPinned
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(65),
                          left: getProportionateScreenWidth(20),
                        ),
                        child: Text(
                          "Search",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: getProportionateScreenWidth(24),
                                  color: AppColors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.openMenu();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(65)),
                          child: Image.asset(
                            "assets/menu_icon.png",
                            width: getProportionateScreenWidth(25),
                            height: getProportionateScreenHeight(25),
                          ),
                        ),
                      )
                    ],
                  )
                : Text(""),
            backgroundColor: AppColors.orange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          sliverbody()
        ],
      ),
    );
  }

  Widget sliverbody() => SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(20),
                  left: getProportionateScreenWidth(28)),
              child: Text(
                "1899 results found",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: AppColors.orange,
                    fontSize: getProportionateScreenWidth(20)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(30),
                  top: getProportionateScreenHeight(20)),
              child: Text(
                "Activities found near you (Montreal, Quebec):",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppColors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(16)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: getProportionateScreenWidth(10),
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20)),
              child: Divider(
                thickness: 2,
                color: AppColors.orange,
              ),
            ),
            ActivityCard(),
            SizedBox(
              height: 20,
            ),
            ActivityCard(),
            SizedBox(
              height: 20,
            ),
            ActivityCard()
          ],
        ),
      );
}
