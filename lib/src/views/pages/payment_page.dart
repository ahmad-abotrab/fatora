import 'package:flutter/material.dart';

import '../widgets/abstract_receipt.dart';

// ignore: must_be_immutable
class PaymentPage extends StatelessWidget {
  PaymentPage({
    Key? key,
    required this.keyForm,
  }) : super(key: key);
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AbstractReceipt(
            keyForm: keyForm,
          ),
        ],
      ),
    );
  }
}
