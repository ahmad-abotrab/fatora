import 'package:fatora/src/Constant/color_app.dart';
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
          submissionButton(),
        ],
      ),
    );
  }

  submissionButton (){
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: MediaQuery.of(context).size.width * 0.5,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorApp.primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            'Add signature',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Forum-Regular',
              color: ColorApp.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
  onPressed(){

  }
}
