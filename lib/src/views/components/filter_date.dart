// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// // ignore: must_be_immutable
// class FilterDate extends StatelessWidget{
//   FilterDate({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Date Range Picker",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 18, bottom: 16),
//         child: Material(
//           color: Colors.transparent,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children:  [
//                   const Text(
//                     'Choose a date Range',
//                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 18,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           FocusScope.of(context).requestFocus(FocusNode());
//
//           showDemoDialog(context: context);
//         },
//         tooltip: 'choose date Range',
//         child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
//       ),
//     );
//   }
//
//   void showDemoDialog({BuildContext? context}) {
//     showDialog<dynamic>(
//       context: context!,
//       builder: (BuildContext context) => CalendarPopupView(
//         barrierDismissible: true,
//         minimumDate: DateTime.now(),
//         initialEndDate: endDate,
//         initialStartDate: startDate,
//         onApplyClick: (DateTime startData, DateTime endData) {
//           setState(() {
//             startDate = startData;
//             endDate = endData;
//           });
//         },
//       ),
//     );
//   }
//   }
// //
// }