import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fatora/pair.dart';
import 'package:fatora/src/data/model/local_id_for_receipt.dart';
import 'package:fatora/src/views/pages/list_receipt_not_sent_by_whats.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/receipts_db.dart';
import '/src/Constant/color_app.dart';
import '/src/constant/constant_value.dart';
import '/src/logic/connection_internet_controller.dart';
import '/src/logic/data_for_payment.dart';
import '/src/logic/form_validation.dart';
import '/src/logic/loading_animation_controller.dart';
import '/src/logic/log_controller.dart';
import '/src/logic/signature_image.dart';
import '/src/views/components/dialog_loading.dart';
import '/src/views/components/loading_widget.dart';
import '/src/views/pages/payment_page.dart';
import '../../Constant/route_screen.dart';
import '../../data/model/receipt_model.dart';
import '../../data/repository/receipt_repository.dart';
import '../../data/web_services/api_pdf.dart';
import '../../data/web_services/pdf_opened.dart';
import '../../logic/data_for_catch.dart';
import 'catch_page.dart';
import 'log_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var formPaymentCon = Get.put(DataForPayment(), permanent: true);
  var formCatchCon = Get.put(DataForCatch(), permanent: true);
  var signatureCon = Get.put(SignaturePageController(), permanent: true);
  var connectInternetStatus =
      Get.put(ConnectionInternetController(), permanent: true);
  List<Receipt> receipts = [];
  TabController? tabController;
  bool? isSelected;
  Color? selectedTabColor;
  late GlobalKey<State> keyLoader = GlobalKey<State>();
  var controllerLogHistory = Get.put<LogController>(LogController());
  final snackbar = SnackBar(
      content: Text(Get.find<ConnectionInternetController>()
          .connectivityResult
          .toString()));
  ReceiptsDB receiptsDB = ReceiptsDB();

  @override
  void initState() {
    keyLoader = GlobalKey<State>();
    controllerLogHistory = Get.put<LogController>(LogController());
    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(
        () {
          signatureCon.updateSelectedIndex(tabController!.index);
        },
      );
    InternetConnectionChecker().onStatusChange.listen((status) {
      bool result = status == InternetConnectionStatus.connected;
      if (result) {
        Connectivity().onConnectivityChanged.listen((connectivityResultValue) {
          connectInternetStatus.changeValues(true, connectivityResultValue);
        });
      } else {
        connectInternetStatus.changeValues(false, ConnectivityResult.none);
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    controllerLogHistory = Get.put<LogController>(LogController());
    keyLoader = GlobalKey<State>();

    tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(
        () {
          signatureCon.updateSelectedIndex(tabController!.index);
        },
      );
    InternetConnectionChecker().onStatusChange.listen((status) {
      bool result = status == InternetConnectionStatus.connected;
      if (result) {
        Connectivity().onConnectivityChanged.listen((connectivityResultValue) {
          connectInternetStatus.changeValues(true, connectivityResultValue);
        });
      } else {
        connectInternetStatus.changeValues(false, ConnectivityResult.none);
      }
    });
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
                children: const [
                  CatchPage(),
                  PaymentPage(),
                ],
              ),
            ),
            GetBuilder<SignaturePageController>(
                init: SignaturePageController(),
                builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.035,
                      left: MediaQuery.of(context).size.width * 0.43,
                    ),
                    child: controller.selectedIndex == 0
                        ? controller.fileNameSignature == ''
                            ? addSignature()
                            : loadImageFromInternalPath(
                                controller.fileNameSignature)
                        : loadSignatureFromAssetFile(
                            'assets/images/signature.png'),
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
    File? pdfFile;
    bool checkIfUploadDataToServer = false;
    int id = 0;
    if (Get.find<SignaturePageController>().fileNameSignature == '') {
      dontHaveSignature();
    } else {
      //condition to complete process
      bool firstCondition = (signatureCon.selectedIndex == 0 &&
          Get.find<FormValidation>().formCatch.currentState!.validate());
      bool secondCondition = (signatureCon.selectedIndex == 1 &&
          Get.find<FormValidation>().formPayment.currentState!.validate());
      //----------
      if (firstCondition || secondCondition) {
        GlobalKey<State> keyLoader1 = GlobalKey<State>();
        Receipt? receipt;
        loadingDialogFun(keyLoader1);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final prefer = sharedPreferences;

        var oldCharIdLocal = prefer.get(charIdAppLocal);
        var oldIdLocal = prefer.get(idAppLocal);
        print("first");
        id = int.parse(oldIdLocal.toString()) + 1;
        receipt = createReceiptToNextProcess(id, oldCharIdLocal);
        Pair pair = await createPdfToNextProcess(receipt);
        receipt.receiptPdfFileName = pair.second;
        String sql = """
              INSERT INTO receipts
              (idLocal,whoIsTake,amountText,amountNumeric,causeOfPayment,date,receiptPdfFileName,statusSend_WhatsApp)
              VALUES (?,?,?,?,?,?,?,?);
           """;

        List data = [
          receipt.idLocal,
          receipt.whoIsTake,
          receipt.amountText,
          receipt.amountNumeric,
          receipt.causeOfPayment,
          receipt.date!.toIso8601String(),
          receipt.receiptPdfFileName,
          receipt.statusSend_WhatsApp,
        ];

        await receiptsDB.insertData(sql, data);

        sql = '';
        sql = '''
              INSERT INTO receiptStatus
              (pathDB,idCharLocal,idLocal,statusSend_WhatsApp,statusSend_Server)
              VALUES (?,?,?,?,?);
          ''';
        data.clear();
        data = [pair.first.path, oldCharIdLocal, receipt.idLocal, 0, 0];

        await receiptsDB.insertData(sql, data);
        print("first");

        List<Map> d =
            await receiptsDB.readData('select * from receipts where id = 2');
        print(d);
        try {
          // here should make store data on database

          await ReceiptRepository()
              .addNewReceipt(receipt, pair.first, pair.second);
          print("first");

          LocalIdForReceipt localID = LocalIdForReceipt(
              charReceiptForEachEmployee: oldCharIdLocal.toString(),
              idReceiptForEachEmployee: id.toString());
          print("first");
          await ReceiptRepository().updateLocalNumId(localID);
          print("first");
          // 'UPDATE Test SET receiptStatus statusSend_Server = ?  WHERE idLocal = ?'
          sql = '''
                  UPDATE receiptStatus
                  SET statusSend_Server = ?
                  WHERE idLocal = ?
                ''';
          data = [1, receipt.idLocal];
          await receiptsDB.updateData(sql, data);

          await prefer.setString(idAppLocal, id.toString());
          Get.find<LoadingAnimationController>().changeStatus();
          await Future.delayed(const Duration(seconds: 1));
          Navigator.of(context, rootNavigator: true).pop();
          await showDialogWhatYouWantDoAfterUploadDataToServer(
              pair.first, receipt.idLocal);
        } catch (e) {
          Navigator.of(context, rootNavigator: true).pop();
          showDialog(
            context: context,
            builder: (_) => WarningDialog(
              content: e.toString(),
            ),
          );
        }
      }
    }
  }

  ifMobileConnectWithInternetByWifi() {}

  Future loadingDialogFun(keyLoader1) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => LoadingWidget(keyLoader: keyLoader1));
  }

  Receipt createReceiptToNextProcess(id, oldCharIDLocal) {
    Receipt receipt = Receipt();
    receipt.idLocal = id.toString() + oldCharIDLocal;
    if (tabController!.index == 0) {
      receipt.whoIsTake = formCatchCon.whoIsTake!.text;
      receipt.amountText = formCatchCon.amountText!.text;
      receipt.amountNumeric = formCatchCon.price!.text.toString();
      receipt.causeOfPayment = formCatchCon.causeOfPayment!.text;
    } else {
      receipt.whoIsTake = formPaymentCon.whoIsTake!.text;
      receipt.amountText = formPaymentCon.amountText!.text;
      receipt.amountNumeric = formPaymentCon.price!.text.toString();
      receipt.causeOfPayment = formPaymentCon.causeOfPayment!.text;
    }
    receipt.date = DateTime.now();
    receipt.statusSend_WhatsApp = 0;

    return receipt;
  }

  createPdfToNextProcess(receipt) async {
    Pair pair = Pair();
    File pdfFile;
    String fileName;
    String imageSignature = 'assets/images/signature.png';
    if (tabController!.index == 0) {
      fileName = 'catch${receipt.idLocal}.pdf';
      pdfFile = await createPdfReceipts(
          fileName,
          receipt,
          Get.find<SignaturePageController>().fileNameSignature,
          receipt.idLocal);
    } else {
      fileName = 'payment${receipt.idLocal}.pdf';
      pdfFile = await createPdfReceipts(
          fileName, receipt, imageSignature, receipt.idLocal);
    }
    pair.first = pdfFile;
    pair.second = fileName;
    return pair;
  }

  dialogWhatYouWantDoAfterUploadDataToServer(pdfFile, id) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('هل تريد ؟ '),
      content: const Text(
        'إرسال الملف حالاً عبد الواتس اب\nعرض ملف الإيصال\nلاشيء.. لكن سيتم حفظ الملف في الـذاكدة المؤقتة لحين إرسالها عبر الواتس آب\n',
        maxLines: 3,
      ),
      actions: [
        IconButton(
            onPressed: () => sendReceiptPdfByWhatsApp(pdfFile!.path, id),
            icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green)),
        IconButton(
            onPressed: () {
              PDFOpened.openFile(pdfFile!);
            },
            icon: const FaIcon(FontAwesomeIcons.filePdf, color: Colors.red)),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('رجوع')),
      ],
    );
  }

  Future showDialogWhatYouWantDoAfterUploadDataToServer(pdfFile, id) async {
    showDialog(
      context: context,
      builder: (_) {
        return dialogWhatYouWantDoAfterUploadDataToServer(pdfFile, id);
      },
    );
  }

  sendReceiptPdfByWhatsApp(file, id) async {
    bool shared = false;
    try {
      await Share.shareFiles([file], text: "هـذا إيصال الدفع الخاص بك");

      shared = true;
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('يوجد خطأ'),
            content: const Text(' لايمكن فتح الواتس اب لان '),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('رجوع'))
            ],
          );
        },
      );
    }
    if (shared) {
      String sql = '''
                  UPDATE receiptStatus
                  SET statusSend_WhatsApp = ?
                  WHERE idLocal = ?;
                  ''';
      List data = [1, id];
      await receiptsDB.updateData(sql, data);
    } else {
      String sql = '''
                  UPDATE receiptStatus
                  SET statusSend_WhatsApp = ?
                  WHERE idLocal = ?;
                  ''';
      List data = [0, id];
      await receiptsDB.updateData(sql, data);
    }
  }

  Future dontHaveSignature() async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        // titlePadding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width*0.01,),
        title: Row(children: [
          const Icon(
            Icons.warning,
            color: Colors.amberAccent,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          const Text('تحذير'),
        ]),
        content: const Text('الرجاء إدخال التوقيع'),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('رجوع'))
        ],
      ),
    );
  }

  createPdfReceipts(fileName, data, imageSignature, id) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd-hh:mm');
    final String dateTime = formatter.format(now);
    Uint8List imagePath;

    //Here this condition to check what is signature which i load
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
          onPressed: () {
            if (tabController!.index == 0) {
              formCatchCon.reinitialize();
            } else {
              formPaymentCon.reinitialize();
            }
            signatureCon.reinitialize();
          },
          icon: const Icon(Icons.cleaning_services_rounded),
          tooltip: 'تهيئة',
        ),
        moreButtonPopButton(context),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorColor: ColorApp.secondaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2,
        labelColor: ColorApp.primaryColor,
        automaticIndicatorColorAdjustment: false,
        tabs: buildTabs(tabController!.index, context),
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
              color: index == 0 ? Colors.white : Colors.white54,
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
              color: index == 1 ? Colors.white : Colors.white54,
              fontFamily: 'Fourm',
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
    return tabs;
  }

  // get receipts form server to open log history
  loadReceiptsFormServer() async {
    try {
      // Loading widget
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => LoadingWidget(
          keyLoader: keyLoader,
        ),
      );

      // connect with api to get data
      await ReceiptRepository()
          .getAllReceipts()
          .then((value) => controllerLogHistory.updateReceiptsList(value));

      // close loading dialog
      Navigator.of(context, rootNavigator: true).pop();

      //go to log history
      Navigator.push(context, MaterialPageRoute(builder: (_) => LogHistory()));
    } catch (e) {
      //close loading
      Navigator.of(context, rootNavigator: true).pop();
      //error widget
      showDialog(
        context: context,
        builder: (_) => WarningDialog(
          content: e.toString(),
        ),
      );
    }
  }

  moreButtonPopButton(context) {
    return PopupMenuButton(
      tooltip: 'المزيد',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: TextButton(
            onPressed: () async {
              // Navigator.pop(context);
              // List<Map> d =  await receiptNotUploadToServer();
              // print(d);
              try {
                List<Map> request = await receiptNotUploadToServer();
                if (request.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title: const Text('تنبيه'),
                            content: const Text('لا يوجد فواتير لم يتم رفعها'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('رجوع'))
                            ],
                          ));
                } else {
                  dialogToShowHowMuchReceiptsNotUploading(request, context);
                }
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: const Text('تنبيه'),
                          content: const Text('لا يوجد بيانات'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('رجوع'))
                          ],
                        ));
              }
            },
            child: Row(
              children: const [
                Icon(Icons.cloud_upload, color: Colors.blue),
                Expanded(child: SizedBox()),
                Text(
                  'رفع الفواتير',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () => loadReceiptsFormServer(),
            child: Row(
              children: const [
                Icon(Icons.history, color: Colors.blue),
                Expanded(child: SizedBox()),
                Text(
                  'السجل',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ListReceiptNotSentByWhatsUp(),
                ),
              );
            },
            child: Row(
              children: const [
                Icon(
                  Icons.whatsapp,
                  color: Colors.green,
                ),
                Expanded(child: SizedBox()),
                Text(
                  'لم يًرسل',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  receiptNotUploadToServer() async {
    String sql = '''
                  SELECT rs.pathDB , r.idLocal , r.whoIsTake, r.amountText , r.amountNumeric , r.causeOfPayment , r.date , r.receiptPdfFileName , r.statusSend_WhatsApp
                  FROM receipts r
                  INNER JOIN receiptStatus rs
                  ON r.idLocal = rs.idLocal
                  WHERE rs.statusSend_Server = 0
              ''';
    List<Map> request = await receiptsDB.readData(sql);
    return request;
  }

  dialogToShowHowMuchReceiptsNotUploading(List<Map> request, context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('عدد الفواتير الغير مرفوعة على السيرفر'),
        content: Text(request.length.toString()),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('رجوع')),
          TextButton(
              onPressed: () async {
                await uploadReceiptToServer(request);
              },
              child: const Text('رفع')),
        ],
      ),
    );
  }

  uploadReceiptToServer(List<Map> request) async {
    Navigator.pop(context);
    loadingDialogFun(keyLoader);
    for (int i = 0; i < request.length; i++) {
      Receipt receiptObject = Receipt(
        idLocal: request[i]['idLocal'],
        whoIsTake: request[i]['whoIsTake'],
        amountText: request[i]['amountText'],
        amountNumeric: request[i]['amountNumeric'],
        causeOfPayment: request[i]['causeOfPayment'],
        date: DateTime.parse(request[i]['date']),
        receiptPdfFileName: request[i]['receiptPdfFileName'],
      );
      File receiptFile = File(request[i]['pathDB']);
      try {
        await ReceiptRepository().addNewReceipt(
            receiptObject, receiptFile, receiptObject.receiptPdfFileName!);
        await ReceiptRepository()
            .updateStatusOfSendReceiptToWhatsApp(receiptObject.idLocal, 0);
        String sql = '''
          UPDATE receiptStatus
          SET statusSend_Server = ?
          WHERE idLocal = ?
      ''';
        List data = [1, request[i]['idLocal']];
        await receiptsDB.updateData(sql, data);

      } catch (e) {
        // print(e.toString());
        Navigator.of(context, rootNavigator: true).pop();
        showDialog(
          context: context,
          builder: (_) => WarningDialog(
            content: e.toString(),
          ),
        );
      }
    }
    Navigator.pop(context);
  }
}
