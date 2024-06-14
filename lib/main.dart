import 'package:fatora/src/constant/url_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fatora_main_class.dart';

// project id in Google Api is [fatora-350313]
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String baseURL = sharedPreferences.getString("baseUrl") ?? "";
  URLApi.baseUrl =
      (baseURL != null && baseURL != "") ? baseURL : "http://185.194.126.157/";
  int s;
  runApp(const Fatora());
}
