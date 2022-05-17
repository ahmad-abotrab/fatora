import 'dart:io';
import 'dart:typed_data';

import 'package:fatora/src/Constant/color_app.dart';
import 'package:fatora/src/data/server/pdf_opened.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Constant/route_screen.dart';
import '../../data/server/api_pdf.dart';
import '../../logic/data_for_catch.dart';
import 'catch_page.dart';
import 'payment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var changeSelectedTab = Get.put(DataForCatch(), permanent: true);

  TabController? tabController;
  bool? isSelected;
  Color? selectedTabColor;
  var keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    keyForm = GlobalKey<FormState>();
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
    keyForm = GlobalKey<FormState>();
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
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: tabController!,
                dragStartBehavior: DragStartBehavior.start,
                children: [
                  CatchPage(keyForm: keyForm),
                  PaymentPage(keyForm: keyForm),
                ],
              ),
            ),
            GetBuilder<DataForCatch>(builder: (controller) {
              return Padding(
                padding: EdgeInsets.only(
                  // top: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.035,
                  left: MediaQuery.of(context).size.width * 0.43,
                ),
                child: tabController!.index == 0
                    ? controller.fileNameSignature == ''
                        ? addSignature()
                        : loadImageFromInternalPath(
                            controller.fileNameSignature)
                    : loadSignatureFromAssetFile('assets/images/signature.png'),
              );
            })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorApp.primaryColor,
          onPressed: onPressedFloatingButton,
          child: const Icon(Icons.done),
        ),
      ),
    );
  }

  addSignature() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorApp.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          Get.toNamed(RouteScreens.signaturePage);
        },
        child: const Text(
          'Add signature',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Forum-Regular',
            color: ColorApp.primaryColor,
          ),
        ),
      ),
    );
  }

  loadSignatureFromAssetFile(pathImageSignature) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorApp.helperColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        pathImageSignature,
        height: MediaQuery.of(context).size.width * 0.25,
        width: MediaQuery.of(context).size.width * 0.4,
      ),
    );
  }

  loadImageFromInternalPath(pathImageSignature) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorApp.helperColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.file(
        File(pathImageSignature),
        height: MediaQuery.of(context).size.width * 0.25,
        width: MediaQuery.of(context).size.width * 0.4,
      ),
    );
  }

  onPressedFloatingButton() async {
    String fileName = '';
    List<String> data = [];
    int id = 0;

    String imageSignature = 'assets/images/signature.png';
    if (tabController!.index == 0) {
      fileName = 'catch{$id}.pdf';
      if (keyForm.currentState!.validate()) {
        final pdfFile = await abstractTaskInSubmissionProcess(
            fileName, data, Get.find<DataForCatch>().fileNameSignature, id);
        PDFOpened.openFile(pdfFile);
      }
    } else {
      if (keyForm.currentState!.validate()) {
        fileName = 'payment{$id}.pdf';
        final pdfFile = await abstractTaskInSubmissionProcess(
            fileName, data, imageSignature, id);
        PDFOpened.openFile(pdfFile);
      }
    }
  }

  abstractTaskInSubmissionProcess(fileName, data, imageSignature, id) async {
    data.add(changeSelectedTab.whoIsTake!.text);
    data.add(changeSelectedTab.price!.text.toString());
    data.add(changeSelectedTab.amountText!.text);
    data.add(changeSelectedTab.causeOfPayment!.text);

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateTime = formatter.format(now);

    Uint8List imagePath;
    if (tabController!.index == 1) {
      imagePath = (await rootBundle.load(imageSignature)).buffer.asUint8List();
    } else {
      File file = File(imageSignature);
      var bytes = await file.readAsBytes();
      imagePath = bytes.buffer.asUint8List();
    }
    return await ApiPdf.generate(fileName, data, imagePath, id, dateTime);
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      title: const FittedBox(
        child: Text(
          "الصفحة الرئيسية",
          style: TextStyle(fontFamily: 'Forum'),
        ),
      ),
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
        indicatorColor: ColorApp.secondaryColor,
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
