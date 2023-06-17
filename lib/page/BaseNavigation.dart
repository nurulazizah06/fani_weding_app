import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/page/PageAccount.dart';
import 'package:fani_wedding/page/PageBeranda.dart';
import 'package:fani_wedding/page/PageOrder.dart';
import 'package:fani_wedding/page/PageProduk.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/XColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BaseNavigation extends StatefulWidget {
  static String? routeName = "/BaseNavigation";

  @override
  State<BaseNavigation> createState() => _BaseNavigationState();
}

class _BaseNavigationState extends State<BaseNavigation> {
  List<Widget> listPage = [
    PageBeranda(),
    PageProduk(),
    PageOrder(),
    PageAccount()
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: listPage[index],
      bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Colors.white,
          unselectedItemColor: XColors.grey_60,
          selectedItemColor: ColorApp.primary,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          items: [
            SalomonBottomBarItem(
              icon: HeroIcon(HeroIcons.home),
              title: Text(
                "Beranda",
              ),
            ),
            SalomonBottomBarItem(
                icon: HeroIcon(HeroIcons.buildingStorefront),
                title: Text("Produk")),
            SalomonBottomBarItem(
                icon: HeroIcon(HeroIcons.clipboard), title: Text("Order")),
            SalomonBottomBarItem(
                icon: HeroIcon(HeroIcons.user), title: Text("Account"))
          ]),
    );
  }
}
