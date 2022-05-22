import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyWidgetResponse extends StatelessWidget {
  const EmptyWidgetResponse({
    Key? key,
    required this.title,
    required this.content,

  }) : super(key: key);

  final String? title;
  final String? content;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: EmptyWidget(
        image: null,
        packageImage: PackageImage.Image_1,
        subTitle: content,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          color: Color(0xff9da9c7),
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xffabb8d6),
        ),
      ),
    );
  }
}
