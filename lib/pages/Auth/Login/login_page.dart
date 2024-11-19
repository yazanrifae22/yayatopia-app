import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yayatopia/blocs/auth/auth_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_event.dart';
import 'package:yayatopia/blocs/auth/auth_state.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:yayatopia/pages/Auth/Register/register_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yayatopia/pages/Main/main_page.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AnimationController controller;
  late AnimationController fadecontroller;

  late Animation<double> animation;

  late Animation<double> animation1;
  late Animation<double> blueciranimationx;
  late Animation<double> blueciranimationy;
  late Animation<double> greenciranimationx;
  late Animation<double> greenciranimationy;
  late Animation<double> papx;
  late Animation<double> papy;
  late Animation<double> girlandstartsy;
  late Animation<double> cardy;
  late Animation<double> logoscal;
  late Animation<double> welcomeanim;
  late Animation<double> usertextfield;
  late Animation<double> passtextfield;
  late Animation<double> fadeanime;
  late Animation<double> logox;
  late Animation<double> logoy;
  late Animation<double> googleanime;
  late Animation<double> facebookanime;
  late double cardvalue;
  late double girlevalue;

  late bool done = false;
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AuthInitialize());
    super.initState();

    fadecontroller =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..addListener(() => setState(() {}));
    logoscal = Tween(begin: 2.0, end: 1.0).animate(fadecontroller);
    fadeanime = Tween(begin: 5.0, end: 0.0).animate(fadecontroller);
    logox = Tween(begin: 90.0, end: 0.0).animate(fadecontroller);
    logoy = Tween(begin: 40.0, end: 0.0).animate(fadecontroller);
    fadecontroller.forward();
    fadecontroller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          done = true;
        });
        controller =
            AnimationController(duration: Duration(seconds: 1), vsync: this)
              ..addListener(() => setState(() {}));

        blueciranimationx = Tween(begin: 100.0, end: 0.0).animate(controller);
        blueciranimationy = Tween(begin: -300.0, end: 0.0).animate(controller);

        animation = Tween(begin: 100.0, end: 0.0).animate(controller);
        animation1 = Tween(begin: -200.0, end: 0.0).animate(controller);

        greenciranimationx = Tween(begin: 50.0, end: 0.0).animate(controller);
        greenciranimationy = Tween(begin: 0.0, end: 0.0).animate(controller);

        papx = Tween(begin: 50.0, end: 0.0).animate(controller);
        papy = Tween(begin: 70.0, end: 0.0).animate(controller);

        girlandstartsy = Tween(begin: 200.0, end: 0.0).animate(controller);

        cardy = Tween(begin: 300.0, end: 0.0).animate(controller);

        welcomeanim = Tween(begin: -240.0, end: 0.0).animate(controller);

        usertextfield = Tween(begin: 140.0, end: 0.0).animate(controller);

        passtextfield = Tween(begin: 240.0, end: 0.0).animate(controller);

        googleanime = Tween(begin: 500.0, end: 0.0).animate(controller);

        facebookanime = Tween(begin: -500.0, end: 0.0).animate(controller);

        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    fadecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    cardvalue = 0.10416666666667 * width;
    girlevalue = 0.1575 * width;

    if (width > 600) {
      cardvalue = getProportionateScreenWidth(20);
      girlevalue = getProportionateScreenWidth(80);
      height = 700;
      width = 400;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height < 800
                  ? size.height + (size.height * 0.01)
                  : size.height,
              child: Stack(
                children: [
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(done ? blueciranimationx.value : 1000,
                          done ? blueciranimationy.value : 1000),
                      child: SvgPicture.asset(
                        "assets/auth/blue_cir.svg",
                        width: width * 0.89583333333333,
                      ),
                    ),
                    right: width * -0.5,
                    top: -0.053267045454545 * height,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(done ? animation.value : 1000,
                          done ? animation1.value : 1000),
                      child: SvgPicture.asset(
                        "assets/auth/yellow_cir_login.svg",
                        width: width * 0.29166666666667,
                      ),
                    ),
                    top: -0.053267045454545 * height,
                    right: 0.20833333333333 * width,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(done ? greenciranimationx.value : 1000,
                          done ? greenciranimationy.value : 1000),
                      child: SvgPicture.asset(
                        "assets/auth/green_cir.svg",
                        width: 0.41666666666667 * width,
                      ),
                    ),
                    top: 0.17045454545455 * height,
                    right: -0.28125 * width,
                  ),
                  Positioned(
                    child: SvgPicture.asset(
                      "assets/auth/white_star.svg",
                      width: 0.0625 * width,
                    ),
                    top: 0.17045454545455 * height,
                    right: 0.1875 * width,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(0, done ? cardy.value : 1000),
                      child: Container(
                        child: Transform.translate(
                            offset: Offset(0, done ? cardy.value : 1000),
                            child: SizedBox()),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.textgray,
                        ),
                        width: size.width * 0.75,
                        height: 0.2503551136363636 * height,
                      ),
                    ),
                    bottom: 0.021306818181818 * height,
                    left: cardvalue,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(0, done ? girlandstartsy.value : 1000),
                      child: Image.asset(
                        "assets/girly.png",
                        width: 0.375 * width,
                      ),
                    ),
                    bottom: 0.20241477272727 * height,
                    right: girlevalue,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(0, done ? cardy.value : 1000),
                      child: Transform.translate(
                        offset: Offset(0, done ? cardy.value : 1000),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.loginMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      fontSize:
                                          getProportionateScreenWidth(21)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0195227272727273 * height),
                              child: SizedBox(
                                height: 0.063920454545455 * height,
                                child: ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(AuthInitialize());
                                      Navigator.pushNamed(
                                        context,
                                        RegisterPage.routeName,
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .joinYayatopia,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    bottom: 0.041306818181818 * height,
                    left: 0.20416666666667 * width,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(
                          done ? papx.value : 1000, done ? papy.value : 1000),
                      child: Image.asset(
                        "assets/pap.png",
                        width: 0.52083333333333 * width,
                      ),
                    ),
                    bottom: -0.053267045454545 * height,
                    right: -0.10416666666667 * width,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(0, done ? girlandstartsy.value : 1000),
                      child: SvgPicture.asset(
                        "assets/auth/blue_star.svg",
                        width: width * 0.039583333333333,
                      ),
                    ),
                    bottom: 0.15980113636364 * height,
                    right: width * 0.14583333333333,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(0, done ? girlandstartsy.value : 1000),
                      child: SvgPicture.asset(
                        "assets/auth/pink_star.svg",
                        width: width * 0.045833333333333,
                      ),
                    ),
                    bottom: 0.31960227272727 * height,
                    right: 0.0625 * width,
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: Offset(0, done ? girlandstartsy.value : 1000),
                      child: SvgPicture.asset(
                        "assets/auth/red_star.svg",
                        width: 0.035416666666667 * width,
                      ),
                    ),
                    bottom: 0.28231534090909 * height,
                    left: width * 0.20833333333333,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.09375, left: width * 0.0625),
                    child: Transform.translate(
                      offset: Offset(0, 0.21306818181818 * height),
                      child: Column(
                        children: [
                          Align(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 0.031960227272727 * height),
                              child: Transform.translate(
                                offset:
                                    Offset(0, done ? welcomeanim.value : 1000),
                                child: Text(
                                  AppLocalizations.of(context)!.welcome,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          fontSize:
                                              getProportionateScreenWidth(34)),
                                ),
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Transform.translate(
                              offset:
                                  Offset(0, done ? usertextfield.value : 1000),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .emailAddress,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          12)))),
                                  SizedBox(
                                    height: 60,
                                    child: BlocConsumer<AuthBloc, AuthState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return TextFormField(
                                            controller: emailController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            15)),
                                            decoration: InputDecoration(
                                              errorText:
                                                  state is AuthInvalidLogin
                                                      ? state.emailError
                                                      : null,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 24),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              fillColor: HexColor("#f5f5f5"),
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              )),
                          Transform.translate(
                              offset:
                                  Offset(0, done ? passtextfield.value : 1000),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                        AppLocalizations.of(context)!.password,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        12),
                                                fontWeight: FontWeight.normal)),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: BlocConsumer<AuthBloc, AuthState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return TextFormField(
                                            controller: passwordController,
                                            obscureText: true,
                                            enableSuggestions: false,
                                            autocorrect: false,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            15)),
                                            decoration: InputDecoration(
                                              errorText:
                                                  state is AuthInvalidLogin
                                                      ? state.passwordError
                                                      : null,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 24),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              fillColor: HexColor("#f5f5f5"),
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              )),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is AuthUnAuthenticated)
                                return Text(
                                  state.error,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize:
                                          getProportionateScreenWidth(14)),
                                );
                              else
                                return SizedBox();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.0085227272727273 * height),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<AuthBloc>(context).add(
                                            AuthLoginEvent(
                                                email:
                                                    emailController.text.trim(),
                                                password:
                                                    passwordController.text));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.login,
                                      )),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.orUse,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize:
                                              getProportionateScreenWidth(13)),
                                ),
                                Row(
                                  children: [
                                    Transform.translate(
                                      offset: Offset(
                                          done ? googleanime.value : 1000,
                                          done ? googleanime.value : 1000),
                                      child: MaterialButton(
                                        height: 55,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(250)),
                                        onPressed: () {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(AuthWithGoogle());
                                        },
                                        color: Color(0XFFE31E30),
                                        child: Icon(
                                          FontAwesomeIcons.google,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Transform.translate(
                                      offset: Offset(
                                          done ? facebookanime.value : 1000,
                                          done ? facebookanime.value : 1000),
                                      child: MaterialButton(
                                        height: 55,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(250)),
                                        onPressed: () {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(AuthWithFacebook());
                                        },
                                        color: Color(0XFF16559F),
                                        child: Icon(
                                          FontAwesomeIcons.facebookF,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  !done
                      ? FadeTransition(
                          opacity: fadeanime,
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: DecoratedBox(
                              decoration:
                                  BoxDecoration(color: HexColor("#01A4CF")),
                            ),
                          ),
                        )
                      : Container(),
                  Positioned(
                    child: ScaleTransition(
                      scale: logoscal,
                      child: Transform.translate(
                        offset: Offset(logox.value, logoy.value),
                        child: SvgPicture.asset(
                          "assets/logo.svg",
                          height: getProportionateScreenHeight(80),
                        ),
                      ),
                    ),
                    top: 0.063267045454545 * height,
                    left: width * 0.0625,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthAuthenticated)
                        Navigator.pushNamedAndRemoveUntil(
                            context, MainPage.routeName, (route) => false);
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(
                                color: AppColors.bluebuttons),
                          ),
                          color: Colors.transparent,
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
