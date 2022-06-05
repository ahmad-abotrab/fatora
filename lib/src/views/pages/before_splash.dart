import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constant/color_app.dart';
import '../../Constant/path_images.dart';
import '../../Constant/route_screen.dart';
import '../../data/model/local_id_for_receipt.dart';
import '../../data/repository/receipt_repository.dart';
import '../components/field_data.dart';

class BeforeSplash extends StatefulWidget {
  const BeforeSplash({Key? key}) : super(key: key);

  @override
  State<BeforeSplash> createState() => _BeforeSplashState();
}

class _BeforeSplashState extends State<BeforeSplash> {
  TextEditingController textEditingController = TextEditingController();

  int state = 0;
  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            logoImageBuilder(size),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FieldData(

                controller: textEditingController,
                labelText: 'أدخل الحرف الذي كان يتكون منه ال id',
                hintText: 'حرف ال id',
                isNumber: false,
                isSuggestion: false,
              ),
            ),
            state == 0
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ColorApp.primaryColor)),
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          var localIdForReceipt = LocalIdForReceipt();
                          localIdForReceipt = await ReceiptRepository()
                              .getLocalIdExits(textEditingController.text);

                          if (localIdForReceipt.idReceiptForEachEmployee ==
                                  null &&
                              localIdForReceipt.charReceiptForEachEmployee ==
                                  null) {
                            setState(() {
                              state = 2;
                              error =
                                  'لا يوجد id يحتوي هذا المحرف الرجاء العودة للصفحة السابقة لإنشاء واحد جديد';
                            });
                          } else {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();

                            final shared = sharedPreferences;

                            await shared.setString('idReceiptForEachEmployee',
                                localIdForReceipt.idReceiptForEachEmployee!);

                            await shared.setString('charReceiptForEachEmployee',
                                localIdForReceipt.charReceiptForEachEmployee!);

                            Navigator.pushReplacementNamed(
                                context, RouteScreens.home);
                          }
                        } catch (e) {
                          setState(() {
                            state = 2;
                            error = e.toString();
                            isLoading = false;
                          });
                        }
                      },
                      child:isLoading ?const CircularProgressIndicator(): const Text('استعادة ال id'),
                    ),
                  )
                : state == 1
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:  Text('يوجد خطأ بالاتصال بالسيرفر'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('الرجاء اضغط لاعادة التحميل'),
                          const SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                state = 0;
                                isLoading = false;
                              });
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: ColorApp.primaryColor,
                            ),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }

  Container logoImageBuilder(Size size) {
    return Container(
      height: size.height * .55,
      width: size.width,
      color: ColorApp.backgroundColor,
      child: Stack(
        children: const [
          Positioned(
            left: 0,
            right: 0,
            bottom: 4,
            child: Image(
              image: AssetImage(logoPath),
            ),
          ),
        ],
      ),
    );
  }
}
