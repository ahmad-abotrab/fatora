import 'package:flutter/material.dart';

import '../../Constant/color_app.dart';
import 'empty_widget_response.dart';

// ignore: must_be_immutable
class DialogLoading extends StatelessWidget {
  DialogLoading({Key? key, required this.content}) : super(key: key);
  String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      contentPadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.000),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.06),
            decoration: const BoxDecoration(
              color: ColorApp.primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                const Icon(Icons.warning, color: Colors.white),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                const Text(
                  "تحذير",
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.07,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.3,
            child: EmptyWidgetResponse(
              title: 'يوجد خطأ',
              content: content,
            ),
          ),
        ],
      ),
      actions: [
        Align(
          child: Container(
            child: TextButton(
              child: const Text('رجوع'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorApp.primaryColor)),
          ),
          alignment: Alignment.bottomRight,
        ),
      ],
    );
  }
}
