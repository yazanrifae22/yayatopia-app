import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yayatopia/blocs/auth/auth_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_event.dart';
import 'package:yayatopia/blocs/auth/auth_state.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:yayatopia/pages/Auth/Login/login_page.dart';
import 'package:yayatopia/pages/Main/main_page.dart';

class SplashPage extends StatefulWidget {
  static String routeName = '/';
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  bool done = true;
  late AnimationController controller;
  late Animation<double> animation;

  late Animation<double> logox;

  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: 300.0, end: 0.0).animate(controller);
    logox = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        BlocProvider.of<AuthBloc>(context).add(AuthGetProfileEvent());
        setState(() {
          done = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated)
            Navigator.pushNamedAndRemoveUntil(
                context, MainPage.routeName, (route) => false);

          if (state is AuthInvalidToken)
            Navigator.pushNamedAndRemoveUntil(
                context, LoginPage.routeName, (route) => false);
        },
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                  child: Transform.translate(
                offset: Offset(0, animation.value),
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.fill),
                )),
              )),
              Positioned(
                top: getProportionateScreenHeight(100),
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/logo.svg",
                      height: getProportionateScreenHeight(160),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 50, right: 50),
                      child: Image.asset(
                        "assets/text.png",
                        height: getProportionateScreenHeight(120),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
