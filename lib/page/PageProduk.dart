import 'dart:convert';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/controller/ProductController.dart';
import 'package:fani_wedding/model/ModelProduct.dart';
import 'package:fani_wedding/page/PageBeranda.dart';
import 'package:fani_wedding/page/PageDetailItem.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:fani_wedding/util/XColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PageProduk extends StatefulWidget {
  static String? routeName = "/PageProduk";
  @override
  State<PageProduk> createState() => _PageProdukState();
}

class _PageProdukState extends State<PageProduk> {
  Future<List<ProductResponse>> fetchProductsByCategory() async {
    final url = Uri.parse('http://${UtilApi.ipName}/api/products');

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

  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return FutureBuilder<List<ProductResponse>>(
            future: fetchProductsByCategory(),
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
                                onPressed: () => {},
                                icon: HeroIcon(
                                  HeroIcons.shoppingCart,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ComponentTextPrimaryTittleBold(
                        teks:
                            "Produk  ${productController.kategoryName.toString()}",
                        size: SizeApp.SizeTextHeader + 10.sp,
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
                            productController.productd.value =
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
                                        'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
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
                                            .keterangan
                                            .toString(),
                                        // style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      SizedBox(height: 10.h),
                                      ComponentTextPrimaryDescriptionBold(
                                        teks: formatCurrency(
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

  List<Product> productList = [
    Product(
      'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
      'Deskripsi Produk 1',
      'Produk 1',
      100,
    ),
    Product(
      'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
      'Deskripsi Produk 2',
      'Produk 2',
      200,
    ),
    Product(
      'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
      'Deskripsi Produk 3',
      'Produk 3',
      300,
    ),
    Product(
      'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
      'Deskripsi Produk 4',
      'Produk 4',
      400,
    ),
    Product(
      'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
      'Deskripsi Produk 5',
      'Produk 5',
      500,
    ),
  ];
}

class Product {
  String? imageURL;
  String? desc;
  String? tittle;
  int harga;
  Product(this.imageURL, this.desc, this.tittle, this.harga);
}

class ProductItem extends StatelessWidget {
  ProductItem(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (ctx) => ProductDetailView(
        //       product: product,
        //     ),
        //   ),
        // );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Extra Wedding',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    product.tittle.toString(),
                    // style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Rp. 1.000.000',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
