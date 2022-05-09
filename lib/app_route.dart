import 'package:fatora/src/Constant/url_path.dart';
import 'package:fatora/src/views/pages/home.dart';
import 'package:fatora/src/views/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  AppRoute();
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case URLPath.splachScreen:
        {
          return MaterialPageRoute(
            builder: (_) {
              return const SplashScreen();
            },
          );
        }
      case URLPath.home:
        {
          return MaterialPageRoute(
            builder: (_) {
              return const HomePage();
            },
          );
        }
    }
    return null;
  }
}
