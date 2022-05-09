import 'package:flutter/material.dart';
import '../../Constant/color_app.dart';
import '../widgets/abstrach_receipt.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AbstrachReceipt(),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.5,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorApp.helperColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/images/signature.png',
              height: MediaQuery.of(context).size.width * 0.25,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        ),
      ],
    );
  }
}
