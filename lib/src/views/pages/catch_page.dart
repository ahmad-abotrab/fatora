import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/form_validation-control.dart';
import '../widgets/abstract_receipt.dart';

// ignore: must_be_immutable
class CatchPage extends StatefulWidget {
  const CatchPage({Key? key}) : super(key: key);

  @override
  State<CatchPage> createState() => _CatchPageState();
}

class _CatchPageState extends State<CatchPage> {
  var controllerValidation = Get.put(FormValidationController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(key:controllerValidation.formStateCatch, child: const AbstractReceipt(),),
          // submissionButton(),
        ],
      ),
    );
  }


}
