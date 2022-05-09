import 'package:fatora/app_route.dart';
import 'package:fatora/src/Constant/color_app.dart';
import 'package:fatora/src/Constant/url_path.dart';
import 'package:fatora/src/views/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/views/pages/home.dart';

void main() {
  runApp(
    Fatora(
      appRoute: AppRoute(),
    ),
  );
}

class Fatora extends StatelessWidget {
  final AppRoute? appRoute;
  const Fatora({Key? key, this.appRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'شركة الأمل',
      initialRoute: '/',
      locale: const Locale('ar', 'SY'), // Arabic,  Syria           country code
      theme: ThemeData(
        primaryColor: ColorApp.primaryColor,
        backgroundColor: ColorApp.backgroundColor,
        bottomAppBarColor: ColorApp.primaryColor,
      ),
      color: ColorApp.primaryColor,
      debugShowCheckedModeBanner: false,

      onGenerateRoute: appRoute!.generateRoute,
      getPages: [
        GetPage(name: URLPath.splachScreen, page: () => const SplashScreen()),
        GetPage(name: URLPath.home, page: () => const HomePage()),
      ],
    );
  }
}
