import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yayatopia/config/size_config.dart';

class FilterSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  const FilterSheetContent({Key? key, required this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      color: AppColors.filterbackground,
      child: Container(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.explore,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: getProportionateScreenWidth(24)),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.apply +
                            " " +
                            AppLocalizations.of(context)!.filters,
                      ),
                      style: ElevatedButtonTheme.of(context).style!.copyWith(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                          ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, top: 16),
                  child: Text(
                    AppLocalizations.of(context)!.filters,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: getProportionateScreenWidth(13)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilterItem(title: "Event Date"),
                      FilterItem(title: "Kid's Age Group"),
                      FilterItem(title: "Location")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, top: 16),
                  child: Text(
                    AppLocalizations.of(context)!.categories,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: getProportionateScreenWidth(13)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 16),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CategoryItem(
                                    title: "All Categories",
                                    iconUrl: "assets/icons/language_icon.svg"),
                                CategoryItem(
                                    title: "Arts & Crafts",
                                    iconUrl: "assets/icons/language_icon.svg"),
                                CategoryItem(
                                    title: "Entertainment",
                                    iconUrl: "assets/icons/language_icon.svg"),
                                CategoryItem(
                                    title: "Food & Drinks",
                                    iconUrl: "assets/icons/language_icon.svg"),
                              ],
                            ),
                            Row(
                              children: [
                                CategoryItem(
                                    title: "Health & Fitness",
                                    iconUrl: "assets/icons/language_icon.svg"),
                                CategoryItem(
                                    title: "Learning & Reading ",
                                    iconUrl: "assets/icons/language_icon.svg"),
                                CategoryItem(
                                    title: "Performance & Media ",
                                    iconUrl: "assets/icons/language_icon.svg"),
                                CategoryItem(
                                    title: "Special Occasion",
                                    iconUrl: "assets/icons/language_icon.svg"),
                              ],
                            )
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  final String title;
  const FilterItem({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            5,
          ),
          border: Border.all(color: AppColors.bluebuttons)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2!.copyWith(
            fontSize: getProportionateScreenWidth(13),
            color: AppColors.bluebuttons),
      ),
    );
  }
}

class CategoryItem extends StatefulWidget {
  final String title;
  final String iconUrl;
  CategoryItem({Key? key, required this.title, required this.iconUrl})
      : super(key: key);
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: Container(
          constraints:
              BoxConstraints(maxHeight: 60, minHeight: 60, minWidth: 100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: selected
                  ? Border.all(color: AppColors.bluebuttons, width: 2)
                  : null),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(widget.iconUrl),
                Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: getProportionateScreenWidth(11)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
