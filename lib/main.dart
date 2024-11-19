import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yayatopia/core/dio_base.dart';
import 'my_app.dart';
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  // Bloc.observer=MyBlocObserver();
  DioBase.init();
  runApp(MyApp());
}