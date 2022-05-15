import 'dart:async';

import 'package:fatora/src/Constant/color_app.dart';
import 'package:fatora/src/Constant/path_images.dart';
import 'package:fatora/src/Constant/url_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Duration duration = const Duration(milliseconds: 3200);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: duration,
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  @override
  void didUpdateWidget(SplashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationController.duration = duration;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  checkAvailableUser() {
    Navigator.pushReplacementNamed(context, URLPath.home);
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(milliseconds: 3400),
      checkAvailableUser,
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            logoImageBuilder(size),
            SizedBox(height: size.height * .12),
            loadingSplash(),
          ],
        ),
      ),
    );
  }

  loadingSplash() {
    return SpinKitCircle(
      color: ColorApp.primaryColor,
      size: 40.0,
      controller: animationController,
    );
  }

  Container logoImageBuilder(Size size) {
    return Container(
      height: size.height * .55,
      width: size.width,
      color: ColorApp.backgroundColor,
      child: Stack(
        children: const [
          Positioned(
            left: 0,
            right: 0,
            bottom: 4,
            child: Image(
              image: AssetImage(logoPath),
            ),
          ),
        ],
      ),
    );
  }
}
