import 'package:flutter/material.dart';
// ignore: must_be_immutable
class LoadingWidget extends StatelessWidget{
   LoadingWidget({Key? key , required this.keyLoader}) : super(key: key);
GlobalKey? keyLoader;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: keyLoader,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            height: 50,
          ),
          Text('جاري التحميل ...'),
        ],
      ),
    );
  }


}