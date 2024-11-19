import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:yayatopia/blocs/auth/auth_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_event.dart';
import 'package:yayatopia/blocs/auth/auth_state.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'password_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String errorText = '';
  @override
  void didChangeDependencies() {
    final AuthState state = BlocProvider.of<AuthBloc>(context).state;
    firstNameController.text =
        (state is AuthAuthenticated) ? state.user.firstName! : '';
    lastNameController.text =
        (state is AuthAuthenticated) ? state.user.lastName! : '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          height: getProportionateScreenHeight(150),
                          child: Stack(
                            // alignment: Alignment.center,
                            children: <Widget>[
                              ClipPath(
                                clipper: MyClip(),
                                child: Container(
                                  height: getProportionateScreenHeight(120),
                                  color: AppColors.googlered,
                                ),
                              ),
                              BlocProvider.of<AuthBloc>(context)
                                          .user
                                          .profileImage ==
                                      null
                                  ? Positioned(
                                      top: getProportionateScreenHeight(45.0),
                                      right: getProportionateScreenWidth(20),
                                      child: Container(
                                        height:
                                            getProportionateScreenHeight(105.0),
                                        width:
                                            getProportionateScreenWidth(105.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: Svg('assets/logo.svg'),
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      top: getProportionateScreenHeight(45.0),
                                      right: getProportionateScreenWidth(20),
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
                              Positioned(
                                bottom: getProportionateScreenHeight(10),
                                top: getProportionateScreenHeight(50),
                                left: getProportionateScreenWidth(20),
                                right: getProportionateScreenWidth(1),
                                child: Container(
                                  child: Text(
                                    AppLocalizations.of(context)!.profile,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    25)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(35)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    state.user.firstName! +
                                        "\n" +
                                        state.user.lastName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    34))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(state.user.email!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      14))
                                      //textAlign: TextAlign.center,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: getProportionateScreenHeight(20.0),
                                  ),
                                  child: Container(
                                    child: OutlinedButton(
                                      onPressed: () => {
                                        Navigator.of(context)
                                            .pushNamed(PasswordPage.routeName),
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!.change +
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
                                            color: AppColors.googlered,
                                            width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 17),
                          child: Form(
                            key: _formKey,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(15),
                                          top:
                                              getProportionateScreenHeight(15)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .tuneYourProfile,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              14))),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .firstName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                12))),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right:
                                                    getProportionateScreenWidth(
                                                        15.0),
                                                bottom:
                                                    getProportionateScreenHeight(
                                                        20)),
                                            child: Center(
                                              child: SizedBox(
                                                child: new TextFormField(
                                                  validator: (str) {
                                                    if (str!.length < 2)
                                                      return 'first name must be at least 6 characters long.';
                                                    return null;
                                                  },
                                                  controller:
                                                      firstNameController,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  16)),
                                                  decoration:
                                                      new InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          16,
                                                                      vertical:
                                                                          8.0),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              const Radius
                                                                      .circular(
                                                                  30.0),
                                                            ),
                                                          ),
                                                          filled: true,
                                                          fillColor: AppColors
                                                              .textgray),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .lastName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              12))),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right:
                                                    getProportionateScreenWidth(
                                                        15.0),
                                                top:
                                                    getProportionateScreenHeight(
                                                        10),
                                                bottom:
                                                    getProportionateScreenHeight(
                                                        20)),
                                            child: Center(
                                              child: SizedBox(
                                                child: new TextFormField(
                                                  validator: (str) {
                                                    if (str!.length < 2)
                                                      return 'Last name must be at least 6 characters long.';
                                                    return null;
                                                  },
                                                  controller:
                                                      lastNameController,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  16)),
                                                  decoration:
                                                      new InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          16,
                                                                      vertical:
                                                                          8.0),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              const Radius
                                                                      .circular(
                                                                  30.0),
                                                            ),
                                                          ),
                                                          filled: true,
                                                          fillColor: AppColors
                                                              .textgray),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            errorText,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom:
                                                    getProportionateScreenHeight(
                                                        10.0)),
                                            child: Container(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    errorText = '';
                                                  });
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    if (firstNameController.text
                                                                .trim() !=
                                                            state.user
                                                                .firstName ||
                                                        lastNameController.text
                                                                .trim() !=
                                                            state.user
                                                                .lastName) {
                                                      BlocProvider.of<AuthBloc>(
                                                              context)
                                                          .add(AuthUpdateProfileEvent(
                                                              firstName:
                                                                  firstNameController
                                                                      .text
                                                                      .trim(),
                                                              lastName:
                                                                  lastNameController
                                                                      .text
                                                                      .trim()));
                                                    } else {
                                                      // setState(() {
                                                      //   errorText="No Changed";
                                                      // });
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .saveChanges,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                            color: AppColors
                                                                .googlered,
                                                            fontSize:
                                                                getProportionateScreenWidth(
                                                                    12))),
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      color:
                                                          AppColors.googlered,
                                                      width: 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
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
