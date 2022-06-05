import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FieldData extends StatelessWidget {
  const FieldData({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.isNumber,
    required this.isSuggestion,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool isNumber;
  final bool isSuggestion;
  static const _locale = 'ar';

  String _formatNumber(String s) {
    if (s.isNotEmpty) {
      return NumberFormat.decimalPattern(_locale).format(int.parse(s));
    }
    return '';
  }

  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06),
      child:  TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لا يمكن ترك هذا الحقل فارغاً';
                }
              },
              controller: controller,
              onChanged: (string) {
                if (isNumber) {
                  if (string.length <= 9) {
                    string = _formatNumber(string.replaceAll(',', ''));
                    controller!.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(offset: string.length),
                    );
                  }
                }
              },
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                focusColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
                hoverColor: Theme.of(context).primaryColor,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
    );
  }
}



/*
isSuggestion
          ? TypeAheadField<String>(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontStyle: FontStyle.italic),
                  decoration:
                      const InputDecoration(border: OutlineInputBorder())),
              suggestionsCallback: (pattern) {
                return ['شركة الحياة', 'شركة الأمل'];
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                print(suggestion);
              },
            )
          :
 */
// String switchToEnglish(String c) {
//   String temp = '';
//   for (int i = 0; i < c.length; i++) {
//     switch (c[i]) {
//       case '١':
//         {
//           temp += '1';
//           break;
//         }
//       case '٢':
//         {
//           temp += '2';
//           break;
//         }
//       case '٣':
//         {
//           temp += '3';
//           break;
//         }
//       case '٤':
//         {
//           temp += '4';
//           break;
//         }
//       case '٥':
//         {
//           temp += '5';
//           break;
//         }
//       case '٦':
//         {
//           temp += '6';
//           break;
//         }
//       case '٧':
//         {
//           temp += '7';
//           break;
//         }
//       case '٨':
//         {
//           temp += '8';
//           break;
//         }
//       case '٩':
//         {
//           temp += '9';
//           break;
//         }
//       default:
//         {
//           temp += '0';
//           break;
//         }
//     }
//   }
//   return temp;
// }
//
// String swtichToArabic(String c) {
//   String temp = '';
//   for (int i = 0; i < c.length; i++) {
//     switch (c[i]) {
//       case '1':
//         {
//           temp += '١';
//           break;
//         }
//       case '2':
//         {
//           temp += '٢';
//           break;
//         }
//       case '3':
//         {
//           temp += '٣';
//           break;
//         }
//       case '4':
//         {
//           temp += '٤';
//           break;
//         }
//       case '5':
//         {
//           temp += '٥';
//           break;
//         }
//       case '6':
//         {
//           temp += '٦';
//           break;
//         }
//       case '7':
//         {
//           temp += '٧';
//           break;
//         }
//       case '8':
//         {
//           temp += '٨';
//           break;
//         }
//       case '9':
//         {
//           temp += '٩';
//           break;
//         }
//       default:
//         {
//           temp += '٠';
//           break;
//         }
//     }
//   }
//   return temp;
// }
//
// bool inRangeNumberArabic(String c) {
//   switch (c[0]) {
//     case '١':
//     case '٢':
//     case '٣':
//     case '٤':
//     case '٥':
//     case '٦':
//     case '٧':
//     case '٨':
//     case '٩':
//     case '٠':
//       return true;
//     default:
//       return false;
//   }
// }
