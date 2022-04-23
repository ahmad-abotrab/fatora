import 'package:flutter/material.dart';

class FieldData extends StatelessWidget {
  const FieldData({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.coins),
          labelText: labelText,
          hintText: hintText,
          // helperText: 'المبلغ',
          // isDense: true,
          // isCollapsed: true,
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
