import 'package:fatora/src/logic/loading_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key? key, required this.keyLoader}) : super(key: key);
  GlobalKey? keyLoader;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: keyLoader,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<LoadingAnimationController>(
              init: LoadingAnimationController(),
              builder: (controller) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: !controller.isDoneLoading
                      ? const CircularProgressIndicator()
                      : const Icon(
                          Icons.done,
                          color: Colors.green,
                          size: 50,
                        ),
                );
              }),
          const SizedBox(
            height: 50,
          ),
          GetBuilder<LoadingAnimationController>(builder: (controller) {
            return !controller.isDoneLoading
                ? const Text('جاري التحميل ...')
                : const Text('تم التحميل.');
          }),
        ],
      ),
    );
  }
}
