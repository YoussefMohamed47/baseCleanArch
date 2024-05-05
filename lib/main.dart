import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire/app/constants.dart';
import 'package:questionnaire/screens/forms/view/forms_view.dart';
import 'package:questionnaire/screens/make_form_template/view/make_form_template_view.dart';

import 'app/Caching/AppResponseCacheService.dart';
import 'app/app_shared.dart';
import 'app/di.dart';
import 'presentation/resources/langauge_manager.dart';
import 'presentation/resources/routes_manager.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

//test
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await EasyLocalization.ensureInitialized();

  await initServeyAppModule();
  await AppResponseCacheService.initInstance();
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(
  //       //statusBarColor: Colors.transparent,
  //     // systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: Colors.transparent, //
  //     ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  HttpOverrides.global = MyHttpOverrides();

  runApp(Phoenix(
      child:  FormsScreen(isQuestionnaires: false,)));
}







