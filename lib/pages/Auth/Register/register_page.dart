import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yayatopia/blocs/auth/auth_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_event.dart';
import 'package:yayatopia/blocs/auth/auth_state.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:yayatopia/pages/Main/main_page.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = 'register';
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordCOntroller =
      TextEditingController();
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AuthInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    if (width > 600) {
      height = 800;
      width = 500;
    }
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AuthBloc>(context).add(AuthInitialize());
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          body: Form(
              child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Stack(
                      children: [
                        Positioned(
                          child: SvgPicture.asset(
                            "assets/logo.svg",
                            width: width * 0.20833333333333,
                          ),
                          top: 0.063267045454545 * height,
                          left: width * 0.0625,
                        ),
                        Positioned(
                            right: -0.3525 * width,
                            top: -0.21306818181818 * height,
                            bottom: 25,
                            child: SvgPicture.asset(
                              "assets/auth/blue_cir.svg",
                              height: 1.0416666666667 * height / 1.9,
                            )),
                        Align(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 0.031960227272727 * height),
                            child: Transform.translate(
                              offset: Offset(
                                  width * 0.0625, 0.21306818181818 * height),
                              child: Text(
                                AppLocalizations.of(context)!.register,
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
                        Positioned(
                          child: SvgPicture.asset(
                            "assets/auth/green_cir.svg",
                          ),
                          right: 0.3125 * width,
                          top: -30,
                        ),
                        Positioned(
                            top: 0.15980113636364 * height,
                            left: 0.55416666666667 * width,
                            child: SvgPicture.asset(
                              "assets/auth/white_star.svg",
                            )),
                        Positioned(
                            top: 0.063920454545455 * height,
                            right: -0.0625 * width,
                            child: SvgPicture.asset(
                              "assets/auth/yellow_cir_register.svg",
                              width: 0.45833333333333 * width,
                              height: 0.234375 * height,
                            )),
                        Positioned(
                            right: -0.0625 * width,
                            top: 0.15980113636364 * height,
                            child: SvgPicture.asset(
                              "assets/auth/pink_cir.svg",
                              width: 0.3125 * width,
                              height: 0.15980113636364 * height,
                            ))
                      ],
                    ),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 20, left: width * 0.0625, right: 35),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.emailAddress,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    12)),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: TextFormField(
                                      controller: emailController,
                                      obscureText: false,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        errorText: state is AuthInvalidRegister
                                            ? state.emailError
                                            : null,
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
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
                                        focusedErrorBorder: OutlineInputBorder(
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
                                      )),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.choose +
                                        " " +
                                        AppLocalizations.of(context)!.password,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    12)),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: TextFormField(
                                      controller: passwordController,
                                      maxLength: 20,
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        counterText: '',
                                        errorText: state is AuthInvalidRegister
                                            ? state.passwordError
                                            : null,
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
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
                                        focusedErrorBorder: OutlineInputBorder(
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
                                      )),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.confirm +
                                        " " +
                                        AppLocalizations.of(context)!.password,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    12)),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: TextFormField(
                                      controller: confirmPasswordCOntroller,
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        errorText: state is AuthInvalidRegister
                                            ? state.passwordConfirmError
                                            : null,
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
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
                                        focusedErrorBorder: OutlineInputBorder(
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
                                      )),
                                )
                              ],
                            ),
                            BlocConsumer<AuthBloc, AuthState>(
                              listener: (contett, i) {},
                              builder: (context, state) {
                                if (state is AuthUnAuthenticated) {
                                  return Text(
                                    state.error,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(AuthRegisterEvent(
                                                  email: emailController.text
                                                      .trim(),
                                                  password:
                                                      passwordController.text,
                                                  confirmPassword:
                                                      confirmPasswordCOntroller
                                                          .text));
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .register,
                                        )),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.orUse,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    13)),
                                  ),
                                  Row(
                                    children: [
                                      MaterialButton(
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
                                      SizedBox(
                                        width: 30,
                                      ),
                                      MaterialButton(
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
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.alreadyUser + " ?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: getProportionateScreenWidth(14),
                                  fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          //width: 0.10416666666667 * width,
                          width: 30,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: AppColors.bluebuttons,
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthInitialize());
                            Navigator.pop(context, false);
                          },
                          child: SizedBox(
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(color: Colors.white),
                            )),
                            height: 0.059659090909091 * height,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
      ))),
    );
  }
}
