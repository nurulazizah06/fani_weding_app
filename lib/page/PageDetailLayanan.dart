import 'dart:convert';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/component/XAlertDialog.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/controller/ProductController.dart';
import 'package:fani_wedding/model/ModelKeranjang.dart';
import 'package:fani_wedding/model/ModelProduct.dart';
import 'package:fani_wedding/page/PageBeranda.dart';
import 'package:fani_wedding/page/PageDetailItem.dart';
import 'package:fani_wedding/page/PageKeranjangSaya.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/Util.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:fani_wedding/util/XColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PageDetailLayanan extends StatefulWidget {
  static String? routeName = "/PageDetailLayanan";
  @override
  State<PageDetailLayanan> createState() => _PageDetailLayananState();
}

class _PageDetailLayananState extends State<PageDetailLayanan> {
  final productController = Get.put(ProductController());

  String imageUrl = 'https://${UtilApi.ipName}/product/';

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

  Future<List<ProductResponse>> fetchProductsByCategory(
      String categoryName) async {
    final url = Uri.parse(
        'https://${UtilApi.ipName}/api/products/category/$categoryName');
    print("Category Name = $categoryName");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<ProductResponse> productList =
          jsonList.map((json) => ProductResponse.fromJson(json)).toList();
      return productList;
    } else {
      throw Exception('Gagal mengambil data produk.');
    }
  }

  void getDataByCategory() {}

  @override
  void initState() {
    super.initState();
    getDataByCategory();
    fetchKeranjangByCustId(accountController.account.value.idakun.toString())
        .then((list) {
      setState(() {
        listKeranjang = list;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  List<ModelKeranjang> listKeranjang = [];

  final productControllers = Get.put(ProductController());
  final accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return FutureBuilder<List<ProductResponse>>(
            future: fetchProductsByCategory(
                productController.kategoryName.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductResponse>? listProductByKategory = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: ColorApp.primary,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50, bottom: 20, left: 10, right: 10),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => {Navigator.of(context).pop()},
                            ),
                            Expanded(
                              child: RoundedSearchBar(),
                            ),
                            IconButton(
                                onPressed: () => {
                                      if (accountController.account.value.email
                                              .value.isEmpty ==
                                          true)
                                        {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return XAlertDialog(
                                                title:
                                                    "Harap Login Terlebih Dahulu",
                                                content:
                                                    "Untuk Mengakses Keranjang",
                                              );
                                            },
                                          )
                                        }
                                      else
                                        {
                                          Get.toNamed(ProductCartView.routeName
                                              .toString())
                                        }
                                    },
                                icon: Stack(children: [
                                  HeroIcon(
                                    HeroIcons.shoppingCart,
                                    color: Colors.white,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          "${listKeranjang.length}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  )
                                ]))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ComponentTextPrimaryTittleBold(
                        teks:
                            "Produk ${productController.kategoryName.toString()}",
                        size: SizeApp.SizeTextHeader.sp,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                        child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.8),
                      itemCount: listProductByKategory!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(ProductDetailView.routeName.toString());
                            productControllers.productd.value =
                                listProductByKategory[index];
                          },
                          child: Card(
                            elevation: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Image.network(
                                        imageUrl +
                                            listProductByKategory[index]
                                                .image
                                                .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ComponentTextPrimaryDescriptionRegular(
                                        teks: listProductByKategory[index]
                                            .category
                                            .toString(),
                                        colorText: XColors.grey_60,
                                      ),
                                      ComponentTextPrimaryDescriptionRegularOverflow(
                                        teks: listProductByKategory[index]
                                            .name
                                            .toString(),
                                        // style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      SizedBox(height: 10.h),
                                      ComponentTextPrimaryDescriptionBold(
                                        teks: UtilFormat.formatPrice(
                                                listProductByKategory[index]
                                                    .price
                                                    .toInt())
                                            .toString(),
                                        colorText: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        },
      ),
    );
  }

  String formatCurrency(int? amount) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatCurrency.format(amount);
  }
}
