import 'package:fatora/src/Constant/color_app.dart';
import 'package:fatora/src/data/server/pdf_opened.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../data/server/api_pdf.dart';
import '../../logic/data_for_catch.dart';
import '../../logic/form_validation-control.dart';
import 'catch_page.dart';
import 'payment_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var changeSelectedTab = Get.put(DataForCatch(), permanent: true);
  var controllerValidation = Get.put(FormValidationController(), permanent: true);
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
          changeSelectedTab.changeSelectedTab(tabController!.index);
        },
      );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(
        () {
          changeSelectedTab.changeSelectedTab(tabController!.index);
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
        body: GetBuilder<DataForCatch>(
            init: DataForCatch(),
            builder: (controller) {
              return TabBarView(
                controller: tabController!,
                dragStartBehavior: DragStartBehavior.start,
                children: const [
                  CatchPage(),
                  PaymentPage(),
                ],
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorApp.primaryColor,
          onPressed: onPressedFloatingButton,
          child: const Icon(Icons.done),
        ),
      ),
    );
  }

  onPressedFloatingButton() async{
    String fileName = '';
    List<String> data = [];
    int id = 0;

    String imageSignature = 'assets/images/signature.png';
    if (tabController!.index == 0) {
      fileName = 'catch{$id}.pdf';
      if (controllerValidation.formStateCatch.currentState!.validate()) {
        final pdfFile  = await abstractTaskInSubmissionProcess(fileName, data, imageSignature, id);
        PDFOpened.openFile(pdfFile);
      }
    } else {
      if (controllerValidation.formStatePayment.currentState!.validate()) {
        fileName = 'payment{$id}.pdf';
        final pdfFile  = await abstractTaskInSubmissionProcess(fileName, data, imageSignature, id);
        PDFOpened.openFile(pdfFile);
      }
    }

  }

  abstractTaskInSubmissionProcess(fileName, data, imageSignature, id) async{
    data.add(changeSelectedTab.whoIsPay!.text);
    data.add(changeSelectedTab.whoIsTake!.text);
    data.add(changeSelectedTab.price!.text.toString());
    data.add(changeSelectedTab.causeOfPayment!.text);

    return await ApiPdf.generate(fileName, data, imageSignature, id);
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      title: const Text(
        "الصفحة الرئيسية",
        style: TextStyle(fontFamily: 'Forum'),
      ),
      leading: null,
      actions: [
        IconButton(
          // splashRadius: ,
          onPressed: () {
            changeSelectedTab.reinitialize();
          },
          icon: const Icon(Icons.cleaning_services_rounded),
          tooltip: 'تهيئة',
        ),
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
        tabs: buildTabs(changeSelectedTab.selectedTabIndex, context),
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
              color: changeSelectedTab.selectedTabIndex == 0
                  ? Colors.white
                  : Colors.white54,
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
              color: changeSelectedTab.selectedTabIndex == 1
                  ? Colors.white
                  : Colors.white54,
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
