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
  var fieldsTest = Get.put<DataForCatch>(DataForCatch(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: GetBuilder<DataForCatch>(
              init: DataForCatch(),
              builder: (_) => Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FieldData(
                    isNumber:false,
                    controller: fieldsTest.whoIsPay,
                    labelText: 'قبضت من السيد ...',
                    hintText: 'قبضت من السيد ...',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FieldData(
                    isNumber:true,
                    controller: fieldsTest.price,
                    labelText: 'مبلغاً وقدره ...',
                    hintText: 'مبلغاً وقدره ...',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FieldData(
                    isNumber:false,
                    controller: fieldsTest.causeOfPayment,
                    labelText: 'وذلك لقاء ...',
                    hintText: 'وذلك لقاء ...',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  FieldData(
                    isNumber:false,
                    controller: fieldsTest.whoIsTake,
                    labelText: 'اسم الذي قبض المال ...',
                    hintText: 'اسم الذي قبض المال ...',
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}
