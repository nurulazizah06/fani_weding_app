import 'dart:convert';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/CartItem.dart';
import 'package:fani_wedding/component/ComponentButton.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/model/ModelKeranjang.dart';
import 'package:fani_wedding/page/PageRingkasanBelanja.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/Util.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:fani_wedding/util/XColors.dart';
import 'package:fani_wedding/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProductCartView extends StatefulWidget {
  static String? routeName = "/ProductCartView";
  @override
  State<ProductCartView> createState() => _ProductCartViewState();
}

class _ProductCartViewState extends State<ProductCartView> {
  Future<List<ModelKeranjang>> fetchKeranjangByCustId(String? custId) async {
    final url = Uri.parse('https://${UtilApi.ipName}/api/keranjang/${custId}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<ModelKeranjang> productList =
          jsonList.map((json) => ModelKeranjang.fromJson(json)).toList();
      return productList;
    } else {
      throw Exception('Gagal mengambil data produk.');
    }
  }

  List<ModelKeranjang> listKeranjang = [];

  Future<void> updateCart(ModelKeranjang modelKeranjang, String custId) async {
    final String url = 'https://${UtilApi.ipName}/api/keranjangupdate';
    Map<String, dynamic> data = {
      'id': modelKeranjang.id.toString(),
      'customer_id': custId,
      'pid': modelKeranjang.pid,
      'name': modelKeranjang.name,
      'price': modelKeranjang.price,
      'quantity': modelKeranjang.quantity,
      'image': modelKeranjang.image,
    };
    print("Data anjay $data");
    String jsonData = jsonEncode(data);

    final response = await http.put(
      Uri.parse(url),
      body: jsonData,
      headers: {'Content-Type': 'application/json'},
    );

    print("response cok ${response.body}");
    if (response.statusCode == 200) {
      // Update berhasil
      print('Cart updated successfully');
    } else {
      // Update gagal
      print('Failed to update cart');
    }
  }

  Future<void> deleteKeranjang(int id) async {
    final String url =
        'https://${UtilApi.ipName}/api/keranjang_hapus/$id'; // Ganti dengan URL API Anda
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      // Hapus berhasil
      print('Customer account deleted successfully');
    } else {
      // Gagal menghapus
      print('Failed to delete customer account');
    }
  }

  @override
  void initState() {
    super.initState();

    fetchKeranjangByCustId(controllerAccount.account.value.idakun.toString())
        .then((list) {
      setState(() {
        listKeranjang = list;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  int totalHargaKeranjang = 0;
  void updateTotalHarga() {
    for (int i = 0; i < listKeranjang.length; i++) {
      totalHargaKeranjang += listKeranjang[i].price!.toInt();
    }
  }

  final controllerAccount = Get.put(AccountController());
  String imageUrl = 'https://${UtilApi.ipName}/product/';
  @override
  Widget build(BuildContext context) {
    totalHargaKeranjang = 0;
    updateTotalHarga();
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return SafeArea(
              child: Column(
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
                      teks: "Keranjang Belanja",
                      colorText: Colors.black,
                      size: SizeApp.SizeTextHeader + 9.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(bottom: Constants.kPaddingM),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () => {
                                    setState(() {
                                      deleteKeranjang(
                                          listKeranjang[index].id!.toInt());
                                      listKeranjang.removeAt(index);
                                    })
                                  },
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.grey,
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Constants.kRadiusL),
                                child: Image.network(
                                  imageUrl +
                                      listKeranjang[index].image.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: Constants.kPaddingL),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComponentTextPrimaryTittleRegular(
                                  teks: listKeranjang[index].name,
                                  size: SizeApp.SizeTextDescription + 13.sp,
                                  colorText: Colors.grey,
                                ),
                                ComponentTextPrimaryTittleRegular(
                                  teks: UtilFormat.formatPrice(
                                      listKeranjang[index].price!.toInt()),
                                  size: SizeApp.SizeTextHeader + 10.sp,
                                  colorText: Colors.grey,
                                ),
                                const SizedBox(height: Constants.kPaddingL),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: ColorApp.primary,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (listKeranjang[index]
                                                    .quantity
                                                    .toInt()! >
                                                1) {
                                              int totQuality =
                                                  listKeranjang[index]
                                                          .quantity
                                                          .toInt()! -
                                                      1;
                                              int totHargaNow =
                                                  listKeranjang[index]
                                                          .productPrice!
                                                          .toInt() *
                                                      totQuality;
                                              listKeranjang[index].setQuantity(
                                                  totQuality.toString());
                                              listKeranjang[index].setPrice(
                                                  totHargaNow.toString());
                                              updateCart(
                                                  listKeranjang[index],
                                                  controllerAccount
                                                      .account.value.idakun
                                                      .toString());
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: Constants.kPaddingM),
                                    ComponentTextPrimaryTittleRegular(
                                      teks: listKeranjang[index]
                                          .quantity
                                          .toString(),
                                      size: SizeApp.SizeTextHeader + 10.sp,
                                      colorText: Colors.black,
                                    ),
                                    const SizedBox(width: Constants.kPaddingM),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: ColorApp.primary,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            int totQuality =
                                                listKeranjang[index]
                                                        .quantity
                                                        .toInt()! +
                                                    1;
                                            int totHargaNow =
                                                listKeranjang[index]
                                                        .productPrice!
                                                        .toInt() *
                                                    totQuality;
                                            listKeranjang[index].setQuantity(
                                                totQuality.toString());
                                            listKeranjang[index].setPrice(
                                                totHargaNow.toString());

                                            updateCart(
                                                listKeranjang[index],
                                                controllerAccount
                                                    .account.value.idakun
                                                    .toString());
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: listKeranjang!.length,
                  padding: const EdgeInsets.all(Constants.kPaddingL),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Constants.kPaddingL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ComponentTextPrimaryTittleRegular(
                      teks: 'Total',
                      size: SizeApp.SizeTextDescription + 20.sp,
                      colorText: Colors.black,
                    ),
                    ComponentTextPrimaryTittleRegular(
                      teks: UtilFormat.formatPrice(totalHargaKeranjang),
                      size: SizeApp.SizeTextDescription + 20.sp,
                      colorText: Colors.black,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0.h),
                  child: ComponentButtonPrimaryWithFunction(
                      "Beli Sekarang",
                      () => {
                            Get.toNamed(
                                PageRingkasanBelanja.routeName.toString())
                          })),
            ],
          ));
        },
      ),
    );
  }
}

class ComponentButtonPrimaryWithFunction extends StatelessWidget {
  String? buttonName;
  Function? func;
  Color? colorButton = ColorApp.PrimaryColor;
  double? sizeTextButton = SizeApp.SizeTextDescription;
  String? routeName;

  ComponentButtonPrimaryWithFunction(this.buttonName, this.func,
      {this.colorButton, this.sizeTextButton, this.routeName});
  @override
  Widget build(BuildContext context) {
    return _Button(context, func, buttonName);
  }

  Widget _Button(BuildContext context, Function? function, String? buttonName) {
    return ElevatedButton(
      onPressed: () {
        func!();
      },
      child: ComponentTextPrimaryTittleBold(
        teks: buttonName,
        size: sizeTextButton,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorApp.PrimaryColor,
          minimumSize: Size.fromHeight(55.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r))),
    );
  }
}
