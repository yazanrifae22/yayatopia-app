import 'package:flutter/material.dart';
import 'package:yayatopia/pages/Main/tabs/Profile/password_page.dart';
import 'package:yayatopia/pages/Main/tabs/Profile/profile_page.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({required this.navigatorKey, Key? key }) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator
    (
      initialRoute: '/',
      key: navigatorKey,
      onGenerateRoute: (routeSetting)
      {
        if(routeSetting.name=='/')
          return MaterialPageRoute(builder: (context)=>ProfilePage());
        if(routeSetting.name==PasswordPage.routeName)
          return MaterialPageRoute(builder: (context)=>PasswordPage());
      },
       
    );
  }
}