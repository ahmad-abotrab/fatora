import 'package:fatora/app_route.dart';
import 'package:fatora/src/Constant/color_app.dart';
import 'package:fatora/src/Constant/url_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    return MaterialApp(
      title: 'شركة الأمل',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // Locale('en', 'UK'), // English, United Kingdom  country code
        Locale('ar', 'SY'), // Arabic,  Syria           country code
      ],
      theme: ThemeData(
        primaryColor: ColorApp.primaryColor,
        backgroundColor: ColorApp.backgroundColor,
        bottomAppBarColor: ColorApp.primaryColor,
      ),
      color: ColorApp.primaryColor,
      debugShowCheckedModeBanner: false,
      initialRoute: URLPath.splachScreen,
      onGenerateRoute: appRoute!.generateRoute,
    );
  }
}
