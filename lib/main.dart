import 'dart:io';

import 'package:fani_wedding/page/BaseNavigation.dart';
import 'package:fani_wedding/page/PageDaftar.dart';
import 'package:fani_wedding/page/PageDetailItem.dart';
import 'package:fani_wedding/page/PageDetailLayanan.dart';
import 'package:fani_wedding/page/PageEditAkun.dart';
import 'package:fani_wedding/page/PageRingkasanBelanja.dart';
import 'package:fani_wedding/page/PageTentangKami.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'page/PageKeranjangSaya.dart';
import 'page/PageSignIn.dart';

void main() async {
  await GetStorage.init();
  HttpClient httpClient = HttpClient();
  httpClient.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;

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
            name: AboutUsView.routeName.toString(), page: () => AboutUsView()),
        GetPage(
            name: BaseNavigation.routeName.toString(),
            page: () => BaseNavigation()),
        GetPage(
            name: PageSignIn.routeName.toString(), page: () => PageSignIn()),
        GetPage(
            name: PageSignUp.routeName.toString(), page: () => PageSignUp()),
        GetPage(
            name: PageEditAkun.routeName.toString(),
            page: () => PageEditAkun()),
        GetPage(
            name: ProductCartView.routeName.toString(),
            page: () => ProductCartView()),
        GetPage(
            name: PageDetailLayanan.routeName.toString(),
            page: () => PageDetailLayanan()),
        GetPage(
            name: ProductDetailView.routeName.toString(),
            page: () => ProductDetailView()),
        GetPage(
            name: PageRingkasanBelanja.routeName.toString(),
            page: () => PageRingkasanBelanja()),
      ],
    );
  }
}
