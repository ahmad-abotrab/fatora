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
    return const AbstrachReceipt();
  }
}
