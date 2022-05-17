import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/Constant/color_app.dart';
import 'src/Constant/route_screen.dart';
import 'src/views/pages/home.dart';
import 'src/views/pages/signature_page.dart';
import 'src/views/pages/splash_screen.dart';

class Fatora extends StatelessWidget {
  const Fatora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'شركة الأمل',
      initialRoute: '/',
      locale: const Locale('ar', 'SY'),
      // Arabic,  Syria           country code
      theme: ThemeData(
        primaryColor: ColorApp.primaryColor,
        backgroundColor: ColorApp.backgroundColor,
        bottomAppBarColor: ColorApp.primaryColor,
      ),
      color: ColorApp.primaryColor,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: RouteScreens.splachScreen, page: () => const SplashScreen()),
        GetPage(name: RouteScreens.home, page: () => const HomePage()),
        GetPage(
            name: RouteScreens.signaturePage,
            page: () => const SignaturePage()),
      ],
    );
  }
}
