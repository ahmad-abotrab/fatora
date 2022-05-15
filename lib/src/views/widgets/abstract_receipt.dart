import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/data_for_catch.dart';
import 'field_data.dart';

// ignore: must_be_immutable
class AbstractReceipt extends StatelessWidget {
  AbstractReceipt({
    Key? key,
    required this.keyForm,
  }) : super(key: key);
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: keyForm,
        child: SingleChildScrollView(
          child: GetBuilder<DataForCatch>(
              init: DataForCatch(),
              builder: (controller) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    FieldData(
                      isNumber: false,
                      controller: controller.whoIsPay,
                      labelText: 'قبضت من السيد ...',
                      hintText: 'قبضت من السيد ...',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    FieldData(
                      isNumber: true,
                      controller: controller.price,
                      labelText: 'مبلغاً وقدره ...',
                      hintText: 'مبلغاً وقدره ...',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    FieldData(
                      isNumber: false,
                      controller: controller.causeOfPayment,
                      labelText: 'وذلك لقاء ...',
                      hintText: 'وذلك لقاء ...',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    FieldData(
                      isNumber: false,
                      controller: controller.whoIsTake,
                      labelText: 'اسم الذي قبض المال ...',
                      hintText: 'اسم الذي قبض المال ...',
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
