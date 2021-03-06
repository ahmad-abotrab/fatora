import 'package:fatora/src/views/pages/create_or_get_local_id.dart';
import 'package:fatora/src/views/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckIfItIsOnceTimeToOpenApp extends StatefulWidget{
  const CheckIfItIsOnceTimeToOpenApp({Key? key}) : super(key: key);

  @override
  State<CheckIfItIsOnceTimeToOpenApp> createState() => _CheckIfItIsOnceTimeToOpenAppState();
}

class _CheckIfItIsOnceTimeToOpenAppState extends State<CheckIfItIsOnceTimeToOpenApp> {

  String? idApp;
  bool initial = true;
  @override
  Widget build(BuildContext context) {
    if(initial){
      SharedPreferences.getInstance().then((value) {
        setState(() {
          idApp = value.getString('isPassword');
          initial = false;
        });
      });
      return const Center(child: CircularProgressIndicator(),);
    }else{
      if(idApp == null){
        return const CreateOrGetLocalId();

      }else{
        return const HomePage();
      }
    }
  }
}