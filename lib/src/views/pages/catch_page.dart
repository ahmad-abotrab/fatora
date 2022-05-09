import 'package:fatora/src/Constant/color_app.dart';
import 'package:flutter/material.dart';
import '../widgets/abstrach_receipt.dart';

// ignore: must_be_immutable
class CatchPage extends StatefulWidget {
  const CatchPage({Key? key}) : super(key: key);

  @override
  State<CatchPage> createState() => _CatchPageState();
}

class _CatchPageState extends State<CatchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AbstrachReceipt(),
        Padding(
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
              onPressed: () {},
              child: const Text(
                'Add signature',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
