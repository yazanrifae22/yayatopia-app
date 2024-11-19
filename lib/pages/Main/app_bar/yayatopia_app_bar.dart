import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yayatopia/blocs/auth/auth_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_state.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: non_constant_identifier_names
AppBar Yayatopia_App_Bar(BuildContext ctx,
    {required VoidCallback openFilter,
    required VoidCallback openMenu,
    required Function search}) {
  String searchValue = '';
  final AuthState state = BlocProvider.of<AuthBloc>(ctx).state;
  return AppBar(
    titleSpacing: 0,
    toolbarHeight: getProportionateScreenHeight(200),
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(10), right: 10),
                child: SvgPicture.asset(
                  "assets/logo.svg",
                  width: getProportionateScreenWidth(55),
                  height: getProportionateScreenHeight(80),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(ctx)!.hello +
                          " " +
                          (state is AuthAuthenticated
                              ? state.user.firstName
                              : '')!,
                      style: Theme.of(ctx).textTheme.bodyText2!.copyWith(
                            fontSize: getProportionateScreenWidth(14),
                          ),
                    ),
                    Text(AppLocalizations.of(ctx)!.appBarMessage,
                        maxLines: 2,
                        style: Theme.of(ctx).textTheme.headline1!.copyWith(
                              height: 1,
                              fontSize: getProportionateScreenWidth(26),
                            ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  openMenu();
                },
                child: Image.asset(
                  "assets/menu_icon.png",
                  width: getProportionateScreenWidth(25),
                  height: getProportionateScreenHeight(25),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(10),
                    right: getProportionateScreenWidth(10),
                    top: 20),
                child: TextFormField(
                    onFieldSubmitted: (str) {
                      search(str);
                    },
                    onChanged: (str) {
                      searchValue = str;
                    },
                    style: Theme.of(ctx)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: getProportionateScreenWidth(15)),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(style: BorderStyle.none)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(style: BorderStyle.none)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(style: BorderStyle.none)),
                        contentPadding:
                            EdgeInsets.all(getProportionateScreenHeight(8)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText:
                            AppLocalizations.of(ctx)!.explore + " Yayatopia",
                        hintStyle: Theme.of(ctx).textTheme.bodyText2!.copyWith(
                            color: AppColors.black3,
                            fontSize: getProportionateScreenWidth(12)),
                        suffixIcon: InkWell(
                          onTap: () {
                            search(searchValue);
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.black26,
                          ),
                        ))),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    openFilter();
                  },
                  child: Image.asset(
                    "assets/filtter.png",
                    height: getProportionateScreenHeight(30),
                    width: getProportionateScreenWidth(20),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
    backgroundColor: AppColors.bluebuttons,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
  );
}
