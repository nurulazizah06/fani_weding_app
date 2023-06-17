import 'package:fani_wedding/component/CartItem.dart';
import 'package:fani_wedding/component/ComponentButton.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/XColors.dart';
import 'package:fani_wedding/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCartView extends StatefulWidget {
  static String? routeName = "/ProductCartView";
  @override
  State<ProductCartView> createState() => _ProductCartViewState();
}

class _ProductCartViewState extends State<ProductCartView> {
  @override
  Widget build(BuildContext context) {
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
                  child: ListView(
                    padding: const EdgeInsets.all(Constants.kPaddingL),
                    children: [
                      CartItem(),
                      CartItem(),
                      CartItem(),
                    ],
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
                        teks: 'Rp. 123.000',
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
                      "Beli Sekarang", () => {}),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
