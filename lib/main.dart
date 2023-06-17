import 'package:fani_wedding/page/BaseNavigation.dart';
import 'package:fani_wedding/page/PageDaftar.dart';
import 'package:fani_wedding/page/PageDetailItem.dart';
import 'package:fani_wedding/page/PageDetailLayanan.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'page/PageKeranjangSaya.dart';
import 'page/PageSignIn.dart';

void main() async {
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: ColorApp.PrimaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorApp.primaryLight,
          primary: ColorApp.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: BaseNavigation.routeName,
      getPages: [
        GetPage(
            name: BaseNavigation.routeName.toString(),
            page: () => BaseNavigation()),
        GetPage(
            name: PageSignIn.routeName.toString(), page: () => PageSignIn()),
        GetPage(
            name: PageSignUp.routeName.toString(), page: () => PageSignUp()),
        GetPage(
            name: ProductCartView.routeName.toString(),
            page: () => ProductCartView()),
        GetPage(
            name: PageDetailLayanan.routeName.toString(),
            page: () => PageDetailLayanan()),
        GetPage(
            name: ProductDetailView.routeName.toString(),
            page: () => ProductDetailView())
      ],
    );
  }
}
