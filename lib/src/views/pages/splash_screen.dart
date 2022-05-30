import 'package:fatora/src/data/repository/receipt_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/Constant/color_app.dart';
import '/src/Constant/path_images.dart';
import '/src/constant/route_screen.dart';
import '/src/logic/local_id_controller.dart';

class SplashScreen extends GetView<LocalIdController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LocalIdController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            logoImageBuilder(size),
            const SizedBox(
              height: 20,
            ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: controller.obx((state) {
            return TextButton(
                autofocus: true,
                onPressed: () async {

                  SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

                  final shared = sharedPreferences;

                  await shared.setString('idReceiptForEachEmployee',
                      state!.idReceiptForEachEmployee!);

                  await shared.setString('charReceiptForEachEmployee',
                      state.charReceiptForEachEmployee!);

                  await ReceiptRepository().addLocalIdToServer(state);
                  Navigator.pushReplacementNamed(
                      context, RouteScreens.home);
                },
                child: const Text('الذهاب للصفحة الرئيسية',style: TextStyle(fontWeight: FontWeight.bold),));
          },
              onLoading: const CircularProgressIndicator(),
              onError: (error) => Column(
                children: [
                  Text(error.toString()),
                  const SizedBox(height: 10,),
                  const Text('الرجاء اضغط لاعادة التحميل'),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    onPressed: () async {
                      await Get.find<LocalIdController>().fetchId();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: ColorApp.primaryColor,
                    ),
                  ),
                ],
              )),
        ),
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
