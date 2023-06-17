import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int qty = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Constants.kPaddingM),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Constants.kRadiusL),
                child: Image.network(
                  'https://www.denkapratama.co.id/img/default-placeholder.f065b10c.png',
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
                  teks: 'Paket Foto',
                  size: SizeApp.SizeTextDescription + 13.sp,
                  colorText: Colors.grey,
                ),
                ComponentTextPrimaryTittleRegular(
                  teks: 'Rp. 500.000',
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
                            if (qty > 0) {
                              qty--;
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: Constants.kPaddingM),
                    ComponentTextPrimaryTittleRegular(
                      teks: qty.toString(),
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
                            qty++;
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
  }
}
