import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/form_validation-control.dart';
import '../widgets/abstract_receipt.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var controllerValidation =
      Get.put(FormValidationController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: controllerValidation.formStatePayment,
            child: const AbstractReceipt(),
          ),
        ],
      ),
    );
  }
}
