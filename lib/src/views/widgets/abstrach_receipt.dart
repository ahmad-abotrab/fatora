import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/data_for_catch.dart';
import 'field_data.dart';

class AbstrachReceipt extends StatefulWidget {
  const AbstrachReceipt({Key? key}) : super(key: key);

  @override
  State<AbstrachReceipt> createState() => _AbstrachReceiptState();
}

class _AbstrachReceiptState extends State<AbstrachReceipt> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            child: GetBuilder<DataForCatch>(
              init: DataForCatch(),
              builder: (_) => Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FieldData(
                    controller: Get.find<DataForCatch>().whoIsPay,
                    labelText: 'قبضت من السيد ...',
                    hintText: 'قبضت من السيد ...',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FieldData(
                    controller: Get.find<DataForCatch>().price,
                    labelText: 'مبلغاً وقدره ...',
                    hintText: 'مبلغاً وقدره ...',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FieldData(
                    controller: Get.find<DataForCatch>().causeOfPayment,
                    labelText: 'وذلك لقاء ...',
                    hintText: 'وذلك لقاء ...',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FieldData(
                    controller: Get.find<DataForCatch>().whoIsTake,
                    labelText: 'اسم الذي قبض المال ...',
                    hintText: 'اسم الذي قبض المال ...',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
