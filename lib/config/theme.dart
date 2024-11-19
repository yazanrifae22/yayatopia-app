import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        bodyText1: base.bodyText1!
            .copyWith(color: AppColors.black3, fontFamily: 'Gilroy light'),
        bodyText2: base.bodyText2!.copyWith(
          color: AppColors.white,
          fontFamily: 'Causten light',
        ),
        button: base.button!
            .copyWith(color: AppColors.white, fontFamily: 'Gilroy Bold'),
        headline2: base.headline2!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy Bold'),
        headline1: base.headline1!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Causten Bold'));
  }

  ThemeData base = ThemeData.light();
  return base.copyWith(
      // scaffoldBackgroundColor: AppColors.white,
      textTheme: _basicTextTheme(base.textTheme),
      primaryColor: AppColors.bluebuttons,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.bluebuttons;
            }
            return AppColors.bluebuttons; // Use the component's default.
          },
        ),
      )),
      buttonTheme:
          ButtonThemeData(buttonColor: AppColors.bluebuttons, minWidth: 1),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.bluebuttons, hoverColor: AppColors.white));
}
