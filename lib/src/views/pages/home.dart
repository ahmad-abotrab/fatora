import 'package:fatora/src/Constant/color_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'catch_page.dart';
import 'payment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex = 0;
  TabController? tabController;
  bool? isSelected;
  Color? selectedTabColor;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(
        () {
          setState(() {
            selectedTabIndex = tabController!.index;
          });
        },
      );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(
        () {
          setState(() {
            selectedTabIndex = tabController!.index;
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: appBar(context),
        body: TabBarView(
          controller: tabController!,
          dragStartBehavior: DragStartBehavior.start,
          children: const [
            CatchPage(),
            PaymentPage(),
          ],
        ),
        drawer: const DrawerApp(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorApp.primaryColor,
          onPressed: onPressedFloatingButton,
          child: const Icon(Icons.done),
        ),
      ),
    );
  }

  onPressedFloatingButton(){
    if (tabController!.index == 0){

    }else{

    }
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      title: const Text(
        "الصفحة الرئيسية",
        style: TextStyle(fontFamily: 'Forum'),
      ),
      // automaticallyImplyLeading: false,
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
        labelColor: ColorApp.primaryColor,
        automaticIndicatorColorAdjustment: false,
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
