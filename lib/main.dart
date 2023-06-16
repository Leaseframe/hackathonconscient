import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Rootes/root_page.dart';

void main() async{
  //await GetStorage.init();
  //HttpOverrides.global = MyHttpoverrides();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: 'MeetBook',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    )
  );
}