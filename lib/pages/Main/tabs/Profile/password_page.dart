import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_event.dart';
import 'package:yayatopia/blocs/auth/auth_state.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class PasswordPage extends StatefulWidget {
  static const routeName = 'password';

  PasswordPage({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController oldPassController = TextEditingController();

  final TextEditingController newPassController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    color: AppColors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: AppColors.white,
                          height: getProportionateScreenHeight(150),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ClipPath(
                                    clipper: MyClip(),
                                    child: Container(
                                      height: getProportionateScreenHeight(120),
                                      color: AppColors.googlered,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                  Icons.arrow_back,
                                                  color: AppColors.white,
                                                  size:
                                                      getProportionateScreenHeight(
                                                          24),
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 16),
                                              child: Text(
                                                "Password",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                        color: AppColors.white,
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                25)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Profile image
                              BlocProvider.of<AuthBloc>(context)
                                          .user
                                          .profileImage ==
                                      null
                                  ? Positioned(
                                      top: getProportionateScreenHeight(45.0),
                                      right: getProportionateScreenWidth(
                                          20), // (background container size) - (circle height / 2)
                                      child: Container(
                                        height:
                                            getProportionateScreenHeight(105.0),
                                        width:
                                            getProportionateScreenWidth(105.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: Svg('assets/logo.svg'),
                                            //fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle,
                                          //color: Colors.green,
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      top: getProportionateScreenHeight(45.0),
                                      right: getProportionateScreenWidth(
                                          20), // (background container size) - (circle height / 2)
                                      child: Container(
                                          width:
                                              getProportionateScreenHeight(105),
                                          height:
                                              getProportionateScreenHeight(105),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: CachedNetworkImageProvider(
                                                      BlocProvider.of<AuthBloc>(
                                                                  context)
                                                              .user
                                                              .profileImage! +
                                                          "?width=250&height=250"),
                                                  fit: BoxFit.fill)))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            color: AppColors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!.changeYour +
                                        " " +
                                        AppLocalizations.of(context)!.password,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    14))),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                      AppLocalizations.of(context)!.old +
                                          " " +
                                          AppLocalizations.of(context)!
                                              .password,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12))),
                                ),
                                Center(
                                  child: SizedBox(
                                    child: TextFormField(
                                      controller: oldPassController,
                                      validator: (val) {
                                        if (val!.length == 0) return "Required";
                                      },
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      16)),
                                      decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 12),
                                          errorText:
                                              state is ChangePasswordError
                                                  ? state.error
                                                  : null,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(30.0),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: AppColors.textgray),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                      AppLocalizations.of(context)!.neww +
                                          " " +
                                          AppLocalizations.of(context)!
                                              .password,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12))),
                                ),
                                Center(
                                  child: SizedBox(
                                    child: TextFormField(
                                      controller: newPassController,
                                      validator: (val) {
                                        if (val!.length < 6)
                                          return 'Password must be at least 6 characters long.';
                                      },
                                      maxLength: 20,
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      16)),
                                      decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 12),
                                          counterText: '',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(30.0),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: AppColors.textgray),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                      AppLocalizations.of(context)!.confirm +
                                          " " +
                                          AppLocalizations.of(context)!
                                              .password,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12))),
                                ),
                                Center(
                                  child: SizedBox(
                                    child: new TextFormField(
                                      controller: confirmPassController,
                                      validator: (val) {
                                        if (val != newPassController.text)
                                          return 'Passwords do not match!';
                                        return null;
                                      },
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      16)),
                                      decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(30.0),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: AppColors.textgray),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                            ChangePasswordEvent(
                                                oldPassword:
                                                    oldPassController.text,
                                                newPassword:
                                                    newPassController.text,
                                                newPasswordConfirm:
                                                    confirmPassController
                                                        .text));
                                      }
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.update +
                                            " " +
                                            AppLocalizations.of(context)!
                                                .password,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                                color: AppColors.googlered,
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        12))),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: AppColors.googlered, width: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              state is AuthLoading
                  ? Container(
                      color: Colors.transparent,
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    )
                  : SizedBox()
            ],
          );
        }, listener: (context, state) {
          if (state is PasswordChanged) {
            Navigator.pop(context);
          }
        }));
  }
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    var controlPoint = Offset(size.width * 0.0127314, size.height * 0.86666);
    var endPoint = Offset(size.width / 15, size.height * 0.86666);
    var controlPoint1 = Offset(size.width * 1.0134259, size.height * 0.86666);
    var endPoint1 = Offset(size.width, size.height * 0.64);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width - (size.width / 15), size.height * 0.86666);

    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
