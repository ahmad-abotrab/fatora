import 'package:flutter/material.dart';

class FieldData extends StatelessWidget {
  const FieldData({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.isNumber,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06),
      child: TextFormField(
        validator: (value) {
          if (isNumber) {
            final isDigitsOnly = int.tryParse(value!);
            return isDigitsOnly == null
                ? 'لا يسمح إلا بادخال أرقام في هذا الحقل'
                : null;
          } else {
            if (value == null || value.isEmpty) {
              return 'لا يمكن ترك هذا الحقل فارغاً';
            }
            return null;
          }
        },
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.coins),
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
