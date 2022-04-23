import 'package:fatora/src/Constant/color_app.dart';
import 'package:flutter/material.dart';

import 'field_data.dart';

// ignore: must_be_immutable
class CatchPage extends StatefulWidget {
  const CatchPage({Key? key}) : super(key: key);

  @override
  State<CatchPage> createState() => _CatchPageState();
}

class _CatchPageState extends State<CatchPage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                // FieldData(
                //   // controller: ,
                //   labelText: 'قبضت من السيد ...',
                //   hintText: 'قبضت من السيد ...',
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.03,
                // ),
                // FieldData(
                //   controller: price,
                //   labelText: 'مبلغاً وقدره ...',
                //   hintText: 'مبلغاً وقدره ...',
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.03,
                // ),
                // FieldData(
                //   controller: causeOfPayment,
                //   labelText: 'وذلك لقاء ...',
                //   hintText: 'وذلك لقاء ...',
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.03,
                // ),
                // FieldData(
                //   controller: whoIsTake,
                //   labelText: 'اسم الذي قبض المال ...',
                //   hintText: 'اسم الذي قبض المال ...',
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
