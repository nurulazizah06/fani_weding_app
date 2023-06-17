import 'dart:convert';

import 'package:bottom_bar_matu/constants.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/controller/ProductController.dart';
import 'package:fani_wedding/page/PageDetailLayanan.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
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
    final url = Uri.parse(
        'https://${UtilApi.ipName.toString()}/api/cart-add'); // Ganti dengan URL endpoint yang sesuai
    final Map<String, dynamic> productData = {
      'customer_id': custId,
      'pid': pid,
      'name': '$name',
      'price': price,
      'quantity': quantity,
      'image': '$image',
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(productData),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData['message']); // Pesan respon dari server
        print(responseData['product']); // Data produk yang disimpan
      } else {
        print('Gagal menyimpan produk. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

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
                      child: ComponentTextPrimaryDescriptionRegular(
                        teks: mproductController.productd.value.name.toString(),
                        colorText: Colors.black,
                        size: SizeApp.SizeTextHeader + 9.sp,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: XScreens.width * 0.55.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Image.network(
                            mproductController.productd.value.image.toString(),
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
                                  ComponentTextPrimaryDescriptionRegular(
                                    teks: mproductController.kategoryName.value,
                                    colorText: Colors.grey,
                                    size: SizeApp.SizeTextDescription + 13.sp,
                                  ),
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
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (qty > 0) {
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
                                SizedBox(width: 10.w),
                                ComponentTextPrimaryDescriptionRegular(
                                  teks: qty.toString(),
                                  size: SizeApp.SizeTextDescription + 13.sp,
                                  colorText: Colors.black,
                                ),
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
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: ComponentTextPrimaryDescriptionRegular(
                          teks: mproductController.productd.value.keterangan
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                ComponentButtonPrimaryWithFunction(
                    "Masukan Keranjang",
                    () => {
                          insertProduct(
                              custId: accountController
                                  .account.value.idakun.value
                                  .toInt(),
                              pid: mproductController.productd.value.id)
                        })
              ],
            );
          },
        ),
      ),
    );
  }
}
