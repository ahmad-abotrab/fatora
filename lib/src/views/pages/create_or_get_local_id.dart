import 'package:fatora/src/constant/constant_value.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '/src/constant/route_screen.dart';
import '../../Constant/color_app.dart';
import '../../Constant/path_images.dart';
import '../../data/repository/receipt_repository.dart';
import '../components/field_data.dart';

class CreateOrGetLocalId extends StatefulWidget {
  const CreateOrGetLocalId({Key? key}) : super(key: key);

  @override
  State<CreateOrGetLocalId> createState() => _CreateOrGetLocalIdState();
}

class _CreateOrGetLocalIdState extends State<CreateOrGetLocalId> {
  TextEditingController userName = TextEditingController();
  TextEditingController ipController = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            logoImageBuilder(size),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FieldData(
                      controller: userName,
                      labelText: 'أدخل اسم المستخدم',
                      hintText: 'اسم المستخدم',
                      isSuggestion: false,
                      isNumber: false,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FieldData(
                      controller: password,
                      labelText: 'كلمة المرور',
                      hintText: 'كلمة المرور',
                      isNumber: false,
                      isSuggestion: false,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: ColorApp.primaryColor,
                            )),
                        child: MaterialButton(
                          onPressed: () async {
                            if (keyForm.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                var isThere = await ReceiptRepository()
                                    .checkIfThereId(userName.text);
                                if (isThere != null &&
                                    password.text == passwordApp) {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();

                                  final shared = sharedPreferences;

                                  await shared.setString('isPassword', 'yes');
                                  await shared.setString(
                                      'charReceiptForEachEmployee',
                                      userName.text);
                                  await shared.setString(
                                      'idReceiptForEachEmployee', isThere);

                                  Navigator.pushReplacementNamed(
                                      context, RouteScreens.home);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text('تنبيه'),
                                            content: const Text(
                                                'كلمة المرور او id غير صحيحة'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('رجوع'))
                                            ],
                                          ));
                                }
                              } catch (error) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: const Text('تنبيه'),
                                    content: Text(error.toString()),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          },
                                          child: const Text('رجوع')),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text('تسجيل الدخول'),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorApp.primaryColor,
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            Get.dialog(
                              AlertDialog(
                                title: const Text("تغيير ip"),
                                content: TextFormField(
                                  autocorrect: true,
                                  controller: ipController,
                                  decoration: InputDecoration(
                                    hintText: "IP ...",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: () async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      String ip =
                                          "http://${ipController.text}:8080/";
                                      sharedPreferences.setString(
                                          "baseUrl", ip);
                                      Get.back();
                                      Get.snackbar(
                                        "تم بنجاح",
                                        "تم بنجاح تغيير ال ip الخاص بك",
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    },
                                    child: const Text("تغيير"),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("تجاهل"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            'تغيير ip',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
