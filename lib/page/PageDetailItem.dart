import 'dart:convert';

import 'package:bottom_bar_matu/constants.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/component/XAlertDialog.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/controller/ProductController.dart';
import 'package:fani_wedding/page/BaseNavigation.dart';
import 'package:fani_wedding/page/PageDetailLayanan.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/Util.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:fani_wedding/util/XColors.dart';
import 'package:fani_wedding/util/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:fani_wedding/component/ComponentButton.dart';
import 'package:get/get.dart';

class ProductDetailView extends StatefulWidget {
  static String? routeName = "/ProductDetailView";
  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final mproductController = Get.put(ProductController());
  final accountController = Get.put(AccountController());
  int qty = 1;
  int totalHarga = 0;
  Future<void> insertProduct(
      {int? custId,
      int? pid,
      String? name,
      int? price,
      int? quantity,
      String? image}) async {
    final url = Uri.parse('http://${UtilApi.ipName}/api/keranjangtambah');

    print("url $url");
    final response = await http.post(
      url,
      body: jsonEncode({
        'customer_id': custId,
        'pid': pid,
        'name': '$name',
        'price': price,
        'quantity': quantity,
        'image': '$image',
      }),
      headers: {'Content-Type': 'application/json'},
    );

    // notifikasi
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.of(context).pop();

      Get.snackbar("Berhasil", "Menambahkan Keranjang");
    } else if (response.statusCode == 201) {
      Navigator.of(context).pop();

      Get.snackbar("Berhasil", "Menambahkan Keranjang");
    }
  }

  static Future<void> register(String username, String email,
      String phoneNumber, String password) async {}

  String imageUrl = 'http://${UtilApi.ipName}/product/';
  @override
  Widget build(BuildContext context) {
    totalHarga = mproductController.productd.value.id!.toInt();
    return Scaffold(
      body: SafeArea(
        child: ScreenUtilInit(
          builder: (context, child) {
            return Column(
              children: [
                Row(
                  // button kembali pada app bar
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: XColors.primary,
                        )),
                    Center(
                      // nama produk pada app bar
                      child: ComponentTextPrimaryDescriptionRegular(
                        teks: mproductController.productd.value.name.toString(),
                        colorText: Colors.black,
                        size: SizeApp.SizeTextHeader + 9.sp,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  // gambar produk
                  child: ListView(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: XScreens.width * 0.55.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Image.network(
                            imageUrl +
                                mproductController.productd.value.image
                                    .toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.h, right: 20.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //kategori produk
                                  ComponentTextPrimaryDescriptionRegular(
                                    teks: mproductController.kategoryName.value,
                                    colorText: Colors.grey,
                                    size: SizeApp.SizeTextDescription + 13.sp,
                                  ),
                                  // harga produk
                                  ComponentTextPrimaryDescriptionRegular(
                                    teks: UtilFormat.formatPrice(
                                            mproductController
                                                    .productd.value.price
                                                    .toInt() *
                                                qty)
                                        .toString(),
                                    colorText: Colors.grey,
                                    size: SizeApp.SizeTextDescription + 13.sp,
                                  ),
                                  // nama product
                                  ComponentTextPrimaryDescriptionRegular(
                                    teks:
                                        mproductController.productd.value.name,
                                    colorText: Colors.black,
                                    size: SizeApp.SizeTextHeader + 14.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              // memberi fungsi pada icon -
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (qty > 1) {
                                        qty--;
                                        totalHarga = qty *
                                            mproductController
                                                .productd.value.price
                                                .toInt();
                                        print("total harga ${totalHarga}");
                                      }
                                    });
                                  },
                                  child: Card(
                                    // button icon -
                                    color: ColorApp.PrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.h,
                                          right: 15.h,
                                          top: 5.h,
                                          bottom: 5.h),
                                      child:
                                          ComponentTextPrimaryDescriptionRegular(
                                        teks: "-",
                                        size: SizeApp.SizeTextHeader + 10.sp,
                                        colorText: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                // jumlah produk
                                SizedBox(width: 10.w),
                                ComponentTextPrimaryDescriptionRegular(
                                  teks: qty.toString(),
                                  size: SizeApp.SizeTextDescription + 13.sp,
                                  colorText: Colors.black,
                                ),
                                // fungsi icon +
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      qty++;
                                      totalHarga = qty *
                                          mproductController
                                              .productd.value.price
                                              .toInt();
                                      print("total harga ${totalHarga}");
                                    });
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    color: ColorApp.PrimaryColor,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.h,
                                          right: 15.h,
                                          top: 5.h,
                                          bottom: 5.h),
                                      child:
                                          ComponentTextPrimaryDescriptionRegular(
                                        teks: "+",
                                        colorText: Colors.white,
                                        size: SizeApp.SizeTextHeader + 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        // deskripsi produk
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: ComponentTextPrimaryDescriptionRegular(
                          teks: mproductController.productd.value.keterangan
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                // button masukan keranjang
                Padding(
                  padding: EdgeInsets.only(bottom: 30, right: 20, left: 20),
                  child: ComponentButtonPrimaryWithFunction(
                      "Masukan Keranjang",
                      () => {
                            if (accountController
                                    .account.value.email.value.isEmpty ==
                                true)
                              {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return XAlertDialog(
                                      title: "Harap Login Terlebih Dahulu",
                                      content:
                                          "Untuk Melakukan Penambahan Keranjang",
                                    );
                                  },
                                )
                              }
                            else
                              {
                                print(
                                    "cust id ${accountController.account.value.idakun.value.toInt()})"),
                                insertProduct(
                                    custId: accountController
                                        .account.value.idakun.value
                                        .toInt(),
                                    pid: mproductController.productd.value.id,
                                    name: mproductController.productd.value.name
                                        .toString(),
                                    price: qty *
                                        mproductController.productd.value.price
                                            .toInt(),
                                    quantity: qty,
                                    image:
                                        mproductController.productd.value.image)
                              },
                          }),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
