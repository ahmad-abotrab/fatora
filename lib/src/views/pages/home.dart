import 'package:fatora/src/Constant/color_app.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  int selectedTabIndex = 0;



 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBarHomePage(),
    );
  }

 

}
