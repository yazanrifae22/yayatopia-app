import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yayatopia/blocs/auth/auth_bloc.dart';
import 'package:yayatopia/blocs/auth/auth_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yayatopia/blocs/home/picks/picks_cubit.dart';
import 'package:yayatopia/pages/Auth/Login/login_page.dart';
import 'package:yayatopia/pages/Auth/Register/register_page.dart';
import 'package:yayatopia/pages/Main/main_page.dart';
import 'package:yayatopia/pages/Splash/splash_page.dart';
import 'config/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError)
        {
          return Center(child: Text("Connection Error"));
        }
        if(snapshot.connectionState==ConnectionState.done)
        {
          return MultiBlocProvider
          (
            providers: 
            [
              BlocProvider(create: (context)=>AuthBloc(Authinitialized()))
            ],
            child: MaterialApp
            (
              
              debugShowCheckedModeBanner: false,
              theme: basicTheme(),
              initialRoute: SplashPage.routeName,
              builder: EasyLoading.init(builder: (context,widget){
                return  MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              }),
              onGenerateRoute: (routeSetting)
              {
                // print(routeSetting.name);
                if(routeSetting.name==SplashPage.routeName)
                  return MaterialPageRoute(builder: (context) => SplashPage());
                else if (routeSetting.name==MainPage.routeName)
                {
                  return MaterialPageRoute(builder: (context) => MultiBlocProvider
                  (
                    providers: 
                    [
                      BlocProvider(create: (context)=>PicksCubit())
                    ], 
                    child: MainPage()));
                }
                else if (routeSetting.name==RegisterPage.routeName)
                {
                  return MaterialPageRoute(builder: (context)=>RegisterPage());
                }
                else if (routeSetting.name==LoginPage.routeName)
                {
                  return MaterialPageRoute(builder: (context)=>LoginPage());
                }
              
              },
              localizationsDelegates: 
              [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: 
              [
                const Locale('en', ''), 
              ],
              )
          );
        }
        return CircularProgressIndicator();
      }
    );
  }
}