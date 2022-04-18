// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../Constant/color_app.dart';

class AppBarHomePage extends StatefulWidget implements PreferredSizeWidget {
  AppBarHomePage({Key? key, @required this.selectedTabIndex}) : super(key: key);
  late int? selectedTabIndex;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<AppBarHomePage> createState() => _AppBarHomePageState();
}

class _AppBarHomePageState extends State<AppBarHomePage>
    with TickerProviderStateMixin {
  TabController? tabController;
  bool? isSelected;
  Color? selectedTabColor;
  Function? callBack;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(
        () {
          setState(() {
            widget.selectedTabIndex = tabController!.index;
          });
        },
      );
  }

  @override
  void didUpdateWidget(covariant AppBarHomePage oldWidget) {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(
        () {
          setState(() {
            widget.selectedTabIndex = tabController!.index;
            callBack:
            () {
              
            };
          });
        },
      );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorApp.primaryColor,
      title: const Text(
        "الصفحة الرئيسية",
        style: TextStyle(fontFamily: 'Forum'),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.sync_outlined),
          tooltip: 'رفع الفواتير',
          autofocus: true,
        ),
        IconButton(
          // splashRadius: ,
          onPressed: () {},
          icon: const Icon(Icons.history),
          tooltip: 'السجل',
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorColor: ColorApp.secondryColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2,
        tabs: buildTabs(selectedTabIndex, context),
      ),
    );
  }

  List<Widget> buildTabs(int index, BuildContext context) {
    List<Widget> tabs = [];

    tabs.add(
      AnimatedSwitcher(
        duration: const Duration(microseconds: 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Text(
            'وصل قبض',
            style: TextStyle(
              color: selectedTabIndex == 0 ? Colors.white : Colors.white54,
              fontFamily: 'Fourm',
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
    tabs.add(
      AnimatedSwitcher(
        duration: const Duration(microseconds: 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Text(
            'وصل دفع',
            style: TextStyle(
              color: selectedTabIndex == 1 ? Colors.white : Colors.white54,
              fontFamily: 'Fourm',
              fontSize: 17,
            ),
          ),
        ),
      ),
    );

    return tabs;
  }
}
