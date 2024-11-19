import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yayatopia/blocs/auth/auth_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_event.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:yayatopia/pages/Splash/splash_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  const MenuSheetContent({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  _MenuItem(
                      child: Text(
                          AppLocalizations.of(context)!.about + " Yayatopia",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  color: AppColors.purple,
                                  fontSize: getProportionateScreenWidth(16))),
                      iconUrl: 'assets/icons/about_icon.svg',
                      backgroundColor: AppColors.purplebackground),
                  _MenuItem(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)!.change +
                                  " " +
                                  AppLocalizations.of(context)!.language,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: AppColors.bluebuttons,
                                      fontSize:
                                          getProportionateScreenWidth(16))),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text("English",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize:
                                            getProportionateScreenWidth(13),
                                        color: AppColors.bluebuttons)),
                          )
                        ],
                      ),
                      iconUrl: 'assets/icons/language_icon.svg',
                      backgroundColor: AppColors.bluebackground),
                  Row(
                    children: [
                      _MenuItem(
                          child: Text(AppLocalizations.of(context)!.help,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: AppColors.orange,
                                      fontSize:
                                          getProportionateScreenWidth(16))),
                          iconUrl: 'assets/icons/help_icon.svg',
                          backgroundColor: AppColors.orangebackground),
                      Expanded(
                        child: _MenuItem(
                            child: Text(AppLocalizations.of(context)!.feedback,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: AppColors.green,
                                        fontSize:
                                            getProportionateScreenWidth(16))),
                            iconUrl: 'assets/icons/feedback_icon.svg',
                            backgroundColor: AppColors.greenbackground),
                      ),
                    ],
                  ),
                  _MenuItem(
                    child: Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                AppLocalizations.of(context)!.inviteYourFriends,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: AppColors.googlered,
                                        fontSize:
                                            getProportionateScreenWidth(16))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.inviteMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColors.googlered,
                                      fontSize:
                                          getProportionateScreenWidth(13)),
                              maxLines: 4,
                            ),
                          )
                        ],
                      ),
                    ),
                    iconUrl: 'assets/icons/invite_icon.svg',
                    backgroundColor: AppColors.redbackground,
                    reverse: true,
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(AuthLogout());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SplashPage()),
                      );
                    },
                    child: _MenuItem(
                        child: Text(AppLocalizations.of(context)!.logout,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: getProportionateScreenWidth(16))),
                        iconUrl: 'assets/icons/logout_icon.svg',
                        backgroundColor: AppColors.blackbackground),
                  ),
                  SvgPicture.asset(
                    "assets/logo.svg",
                    width: 100,
                    height: 100,
                  ),
                  Image.asset(
                    "assets/text.png",
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final Widget child;
  final String iconUrl;
  final Color backgroundColor;
  final bool reverse;
  const _MenuItem(
      {Key? key,
      required this.child,
      required this.iconUrl,
      required this.backgroundColor,
      this.reverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(15)),
          constraints: BoxConstraints(minHeight: 73, minWidth: 130),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: reverse
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              textDirection: reverse ? TextDirection.rtl : TextDirection.ltr,
              children: [
                SvgPicture.asset(iconUrl),
                SizedBox(
                  width: 20,
                ),
                child
              ],
            ),
          )),
    );
  }
}
