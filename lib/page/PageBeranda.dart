import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/component/XAlertDialog.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/controller/ProductController.dart';
import 'package:fani_wedding/page/PageDetailLayanan.dart';
import 'package:fani_wedding/page/PageKeranjangSaya.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class PageBeranda extends StatelessWidget {
  final accountController = Get.put(AccountController());
  final productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                          Expanded(child: RoundedSearchBar()),
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
                              icon: HeroIcon(
                                HeroIcons.shoppingCart,
                                color: Colors.white,
                              ))
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
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ComponentTextPrimaryDescriptionRegular(
                                    teks: "Temukan Disini",
                                    size: SizeApp.SizeTextHeader.sp,
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
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        prefixIcon: Icon(Icons.search),
        hintText: 'Telusuri Produk',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
