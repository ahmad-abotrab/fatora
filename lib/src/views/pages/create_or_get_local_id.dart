import 'package:flutter/material.dart';

import '/src/constant/route_screen.dart';
import '../../Constant/color_app.dart';
import '../../Constant/path_images.dart';

class CreateOrGetLocalId extends StatelessWidget {
  const CreateOrGetLocalId({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            logoImageBuilder(size),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            const Text('هل استخدمت التطبيق من قبل'),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorApp.primaryColor)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteScreens.beforeSplashScreen);
                    },
                    child: const Text('استخدمت'),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorApp.primaryColor)),
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteScreens.splashScreen);
                      },
                      child: const Text('لم استخدمه')),
                ),
                const Expanded(child: SizedBox()),
              ],
            )
          ],
        ),
      ),
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
