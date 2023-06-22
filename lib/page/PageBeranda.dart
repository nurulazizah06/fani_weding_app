import 'dart:convert';

import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/component/XAlertDialog.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/controller/ProductController.dart';
import 'package:fani_wedding/model/ModelKeranjang.dart';
import 'package:fani_wedding/page/PageDetailLayanan.dart';
import 'package:fani_wedding/page/PageKeranjangSaya.dart';
import 'package:fani_wedding/page/PageProduk.dart';
import 'package:fani_wedding/page/PageTelusuriProduk.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class PageBeranda extends StatefulWidget {
  @override
  State<PageBeranda> createState() => _PageBerandaState();
}

class _PageBerandaState extends State<PageBeranda> {
  final productController = Get.put(ProductController());

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

  final accountController = Get.put(AccountController());

  List<ModelKeranjang> listKeranjang = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    fetchKeranjangByCustId(accountController.account.value.idakun.toString())
        .then((list) {
      setState(() {
        listKeranjang = list;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [ColorApp.primary, ColorApp.page],
                  )),
                  padding:
                      EdgeInsets.only(top: SizeApp.SizePaddingHorizontal.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/apps/logo.png"),
                            radius: 20.r,
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
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            children: [
                              ComponentTextPrimaryTittleRegular(
                                teks: "Temukan Solusi Terbaik",
                                size: SizeApp.SizeTextHeader.sp,
                              ),
                              ComponentTextPrimaryTittleBold(
                                teks: "Acara Impian Anda",
                                size: SizeApp.SizeTextHeader.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(PageProduk.routeName.toString());
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        ComponentTextPrimaryDescriptionRegular(
                                      teks: "Temukan Disini",
                                      size: SizeApp.SizeTextHeader.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Image.asset(
                              "assets/images/woman.png",
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ComponentTextPrimaryTittleBold(
                    teks: "Layanan Kami",
                    size: SizeApp.SizeTextHeader.sp,
                  ),
                ),
                Expanded(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.3),
                  itemCount: listItemLayanan.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          productController.kategoryName.value =
                              listItemLayanan[index].idCategory.toString();
                          Get.toNamed(PageDetailLayanan.routeName.toString());
                        },
                        child: WidgetItemLayanan(listItemLayanan[index]));
                  },
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  List<ItemLayanan> listItemLayanan = [
    ItemLayanan("MakeUp", "assets/images/cat-makeup.png", false, "Makeup"),
    ItemLayanan(
        "Paket Wedding", "assets/images/cat-paket.png", false, "Paket Wedding"),
    ItemLayanan(
        "Extra Wedding", "assets/images/cat-extra.png", false, "Extra Wedding"),
    ItemLayanan(
        "Paket Foto", "assets/images/cat-foto.png", false, "Paket Foto"),
  ];
}

class ItemLayanan {
  String? namaLayanan;
  String? assetsPath;
  bool? isSelected;
  String? idCategory;
  ItemLayanan(
      this.namaLayanan, this.assetsPath, this.isSelected, this.idCategory);
}

class WidgetItemLayanan extends StatelessWidget {
  ItemLayanan? itemLayanan;
  WidgetItemLayanan(this.itemLayanan);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            color: ColorApp.PrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    itemLayanan!.assetsPath.toString(),
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                ),
                ComponentTextPrimaryTittleBold(
                  teks: itemLayanan!.namaLayanan.toString(),
                  size: SizeApp.SizeTextHeader.sp,
                )
              ],
            )),
      ),
    );
  }
}

class RoundedSearchBar extends StatelessWidget {
  RoundedSearchBar({this.textEditing});
  TextEditingController? textEditing;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(PageTelusuriProduk.routeName.toString());
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: ColorApp.primary,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Telusuri Produk"),
              ],
            ),
          )),
    );
  }
}
