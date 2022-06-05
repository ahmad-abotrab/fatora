import 'package:fatora/src/views/pages/before_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/Constant/color_app.dart';
import 'src/constant/route_screen.dart';
import 'src/views/pages/check_if_it_is_once_time_to_open_app.dart';
import 'src/views/pages/home.dart';
import 'src/views/pages/signature_page.dart';

class Fatora extends StatelessWidget {
  const Fatora({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'شركة الأمل',
      initialRoute: '/',
      locale: const Locale('ar', 'SY'),
      theme: ThemeData(
        primaryColor: ColorApp.primaryColor,
        backgroundColor: ColorApp.backgroundColor,
        bottomAppBarColor: ColorApp.primaryColor,
      ),
      color: ColorApp.primaryColor,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: RouteScreens.checkIfItOnceTimeOpenApp,
          page: () => const CheckIfItIsOnceTimeToOpenApp(),
        ),
        GetPage(
          name: RouteScreens.home,
          page: () => const HomePage(),
        ),
        GetPage(
          name: RouteScreens.signaturePage,
          page: () => const SignaturePage(),
        ),
        GetPage(
          name: RouteScreens.beforeSplashScreen,
          page: () =>  const BeforeSplash(),
        ),
      ],
    );
  }
}
