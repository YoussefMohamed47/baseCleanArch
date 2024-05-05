import 'package:questionnaire/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String appOptionPage = "/AppOptions";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String home = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.splashRoute:
      //   return MaterialPageRoute(builder: (_) => const AppSplash());
      //   case Routes.home:
      //     initHomeModule();
      //   return MaterialPageRoute(builder: (_) => const Home());
      // case Routes.loginRoute:
      //   initLoginModule();
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case Routes.onBoardingRoute:
      //   return MaterialPageRoute(builder: (_) => const OnBoardingView());
      // case Routes.forgotPasswordRoute:
      //   initForgotPasswordModule();
      //   return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      // case Routes.mainRoute:
      //   initHomeModule();
      //   return MaterialPageRoute(builder: (_) => const MainView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(""),
              ),
              body: Center(child: Text("")),
            ));
  }
}
