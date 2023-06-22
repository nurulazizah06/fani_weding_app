import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/page/PageEditAkun.dart';
import 'package:fani_wedding/page/PageSignIn.dart';
import 'package:fani_wedding/page/PageTentangKami.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:fani_wedding/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class PageAccount extends StatefulWidget {
  static String? routeName = "/PageAccount";
  @override
  State<PageAccount> createState() => _PageAccountState();
}

class _PageAccountState extends State<PageAccount> {
  final accountController = Get.put(AccountController());
  String imageUrl = 'https://${UtilApi.ipName}/product/';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return ScreenUtilInit(
            builder: (context, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: Constants.kPaddingL),
                    decoration: const BoxDecoration(
                      color: ColorApp.primary,
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(Constants.kPaddingL),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: Constants.kPaddingL),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComponentTextPrimaryTittleBold(
                                    teks: accountController.account.value
                                                .username.value.isEmpty ==
                                            true
                                        ? "Username "
                                        : accountController
                                            .account.value.username.value),
                                ComponentTextPrimaryTittleRegular(
                                    teks: accountController.account.value
                                                .phoneNumber.value.isEmpty ==
                                            true
                                        ? "Nomor Telepon "
                                        : accountController
                                            .account.value.phoneNumber.string),
                                ComponentTextPrimaryTittleRegular(
                                    teks: accountController.account.value.email
                                                .value.isEmpty ==
                                            true
                                        ? "Email "
                                        : accountController
                                            .account.value.email.value),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Constants.kPaddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(thickness: 2),
                        accountController.account.value.email.value.isEmpty !=
                                true
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(
                                          PageEditAkun.routeName.toString());
                                    },
                                    child: Text(
                                      'Edit Profil',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                  Divider(thickness: 2),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(
                                          AboutUsView.routeName.toString());
                                    },
                                    child: Text(
                                      'Tentang Kami',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                  Divider(thickness: 2),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Konfirmasi Log-Out"),
                                            content: Text(
                                                "Anda yakin ingin log-out?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  // Hapus akun dari shared preferences
                                                  setState(() {
                                                    accountController
                                                        .clearAccount();
                                                  });
                                                  // Tutup dialog
                                                  Navigator.of(context).pop();
                                                  // Lakukan tindakan log-out lainnya, seperti mengalihkan pengguna ke halaman login
                                                },
                                                child: Text("Ya"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Tutup dialog
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Batal"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Log-Out',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                  Divider(thickness: 2),
                                ],
                              )
                            : TextButton(
                                onPressed: () {
                                  Get.toNamed(PageSignIn.routeName);
                                },
                                child: Text(
                                  'Log-In',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
