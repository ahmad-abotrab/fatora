// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// // ignore: must_be_immutable
// class ChoiceUser extends StatefulWidget {
//   ChoiceUser({Key? key, this.company}) : super(key: key);
  
//   final company;

//   @override
//   _ChoiceUserState createState() => _ChoiceUserState();
// }

// class _ChoiceUserState extends State<ChoiceUser> {
 
//   TextEditingController nameEmployeeController = TextEditingController();
//   TextEditingController pinController = TextEditingController();
//   bool styleActivePinColor = false;
//   List<Widget> list = [];
//   // ..text = "123456";

//   // ignore: close_sinks
//   StreamController<ErrorAnimationType>? errorController;

//   bool hasError = false;
//   String currentText = "";
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     errorController = StreamController<ErrorAnimationType>();
//     list = [];

//     super.initState();
//   }

//   @override
//   void dispose() {
//     errorController!.close();
//     list = [];

//     super.dispose();
//   }

//   buildSnackBar(name) {
//     return SnackBar(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.grey[600],
//         elevation: 8,
//         duration: const Duration(milliseconds: 900),
//         content:const  Text("Hello mazen"));
//   }

//   @override
//   Widget build(BuildContext context) {
  
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pushNamedAndRemoveUntil(
//                   context, '\login', (route) => false);
//             },
//             icon: Icon(Icons.arrow_back)),
//         title: Text("Enter Pin"),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.98,
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Theme.of(context).hintColor),
//                   borderRadius: BorderRadius.circular(19),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.width * 0.05),
//                       width: MediaQuery.of(context).size.width * 0.8,
//                       child: typeHeadFieldSearchCustomer(),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.width * 0.2,
//                     ),
//                     Security.maxNumberOfAttempts > Security.numberOfAttempts
//                         ? Form(
//                             key: formKey,
//                             child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8.0, horizontal: 30),
//                                 child: pinCodeText(context)),
//                           )
//                         : TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               DemoLocalizations.of(context)
//                                   .translate('choiceUser', 'OverTimesInterPin'),
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   decoration: TextDecoration.underline),
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   onComplete(v) async {
//     if (v == employee.pin) {
//       setState(() {
//         styleActivePinColor = true;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(employee.name));
//       SharedPreferences shared_User = await SharedPreferences.getInstance();
//       Map<String, dynamic> jsonString = {
//         "workHours": employee.workHours,
//         "costOfEachHour": employee.costOfEachHour,
//         "salary": employee.salary,
//         "career": employee.career,
//         "password": employee.password,
//         "pin": employee.pin,
//       };

//       String user = jsonEncode(Employee.fromJson(jsonString));
//       shared_User.setString('user', user);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => BottomNav(
//                     customers: customers,
//                     employee: employee,
//                   )));
//     } else {
//       Security.numberOfAttempts++;
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                   title: Text(DemoLocalizations.of(context)
//                       .translate('choiceUser', 'titleDialog')),
//                   content: Text(DemoLocalizations.of(context)
//                           .translate('choiceUser', 'content_first') +
//                       (Security.maxNumberOfAttempts - Security.numberOfAttempts)
//                           .toString() +
//                       DemoLocalizations.of(context)
//                           .translate('choiceUser', 'content_second')),
//                   actions: [
//                     MaterialButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(DemoLocalizations.of(context)
//                             .translate('choiceUser', 'buttonBackDialog')))
//                   ]));
//     }
//   }

//   PinCodeTextField pinCodeText(BuildContext context) {
//     return PinCodeTextField(
//       // readOnly: true,
//       onChanged: (value) {},
//       appContext: context,
//       pastedTextStyle: TextStyle(
//         color: Colors.green,
//         fontWeight: FontWeight.bold,
//       ),
//       length: 4,
//       // obscureText: true,
//       // obscuringCharacter: '*',
//       // obscuringWidget: FlutterLogo(
//       //   size: 24,
//       // ),
//       blinkWhenObscuring: true,
//       animationType: AnimationType.fade,
//       validator: (v) {
//         if (v.length < 3) {
//           return DemoLocalizations.of(context)
//               .translate('choiceUser', 'validatorPin');
//         } else {
//           return null;
//         }
//       },
//       pinTheme: PinTheme(
//         activeColor: Colors.green,
//         // activeColor: styleActivePinColor ? Colors.green : Colors.red,
//         inactiveFillColor: Colors.grey,
//         inactiveColor: Colors.grey,
//         shape: PinCodeFieldShape.box,
//         borderRadius: BorderRadius.circular(5),
//         fieldHeight: 50,
//         fieldWidth: 40,
//         activeFillColor: Colors.white,
//       ),
//       cursorColor: Colors.black,
//       animationDuration: Duration(milliseconds: 300),
//       enableActiveFill: true,
//       errorAnimationController: errorController,
//       controller: pinController,
//       keyboardType: TextInputType.number,
//       boxShadows: [
//         BoxShadow(
//           offset: Offset(0, 1),
//           color: Colors.black12,
//           blurRadius: 10,
//         )
//       ],
//       onCompleted: onComplete,

//       // onChanged: (value) {
//       //   print(value);
//       //   setState(() {
//       //     currentText = value;
//       //     print(currentText);
//       //   });
//       //   print(currentText);
//       // },
//       beforeTextPaste: (text) {
//         print("Allowing to paste $text");
//         //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//         //but you can show anything you want here, like your pop up saying wrong paste format or etc
//         return true;
//       },
//     );
//   }

//   TypeAheadField<Employee> typeHeadFieldSearchCustomer() {
//     return TypeAheadField<Employee>(
//       textFieldConfiguration: TextFieldConfiguration(
//           style: TextStyle(color: Theme.of(context).hintColor),
//           controller: nameEmployeeController,
//           decoration: InputDecoration(
//               prefixIcon: Icon(Icons.person_search, color: Colors.grey),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(28),
//                 borderSide: BorderSide(
//                   color: Colors.grey,
//                 ),
//               ),
//               hintStyle: TextStyle(color: Theme.of(context).hintColor),
//               labelText: DemoLocalizations.of(context)
//                   .translate('choiceUser', 'hintAndLableText'),
//               hintText: DemoLocalizations.of(context)
//                   .translate('choiceUser', 'hintAndLableText'))),
//       suggestionsCallback: (pattern) async {
//         return widget.employees.where((element) {
//           final patternLowerCase = pattern.toLowerCase();
//           final nameLowerCase = element.name.toLowerCase();
//           return nameLowerCase.contains(patternLowerCase);
//         }).toList();
//       },
//       itemBuilder: (context, suggestion) {
//         return ListTile(
//           title: Text(suggestion.name),
//         );
//       },
//       onSuggestionSelected: (suggestion) {
//         setState(() {
//           pinController = new TextEditingController();
//           employee = suggestion;
//           nameEmployeeController.text = employee.name;
//         });
//       },
//     );
//   }
// }
