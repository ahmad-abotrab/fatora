import 'package:fatora/src/logic/data_for_payment.dart';
import 'package:fatora/src/logic/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/field_data.dart';

// ignore: must_be_immutable
class PaymentPage extends StatelessWidget {
  const PaymentPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GetBuilder<FormValidation>(
            init: FormValidation(),
              builder: (controller) {
                return SafeArea(
                  child: Form(
                    key: controller.formPayment,
                    child: SingleChildScrollView(
                      child: GetBuilder<DataForPayment>(
                          init: DataForPayment(),
                          builder: (controller) {
                            return builderInGetBuilderForm(controller, context);
                          }),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  builderInGetBuilderForm(controller, context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        FieldData(
          isNumber: false,
          controller: controller.whoIsTake,
          labelText: 'قبضت من السيد ...',
          hintText: 'قبضت من السيد ...',
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        FieldData(
          isNumber: true,
          controller: controller.price,
          labelText: 'مبلغاً وقدره رقماً ...',
          hintText: 'مبلغاً وقدره رقماً ...',
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        FieldData(
          isNumber: false,
          controller: controller.amountText,
          labelText: 'مبلغاً وقدره كتابةً ...',
          hintText: 'مبلغاً وقدره كتابةً ...',
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
      ],
    );
  }
}
