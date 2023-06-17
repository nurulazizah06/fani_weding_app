import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/XColors.dart';
import 'package:fani_wedding/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons/heroicons.dart';

class PageOrder extends StatefulWidget {
  static String? routeName = "/PageOrder";
  @override
  State<PageOrder> createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                color: ColorApp.primary,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50, bottom: 20, left: 10, right: 10),
                  child: Row(
                    children: [
                      ComponentTextPrimaryTittleBold(
                        teks: "Riwayat Order",
                        size: SizeApp.SizeTextHeader + 10.sp,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      IconButton(
                          onPressed: () => {},
                          icon: HeroIcon(
                            HeroIcons.shoppingCart,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return OrderItem(Order());
                },
                itemCount: 10,
              )
            ],
          );
        },
      ),
    );
  }
}

class Order {}

class OrderItem extends StatelessWidget {
  OrderItem(this.order);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constants.kPaddingL.h),
      margin: EdgeInsets.only(bottom: Constants.kPaddingL.h),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(
          Constants.kPaddingL,
        ),
      ),
      child: Column(
        children: [
          _item(context, title: 'Nama', value: 'Wijayanto'),
          _item(context, title: 'Email', value: 'user@gmail.com'),
          _item(context, title: 'Nomor Telepon', value: '0821478913'),
          _item(context, title: 'Alamat', value: 'Jl. dimana aja'),
          _item(context, title: 'Tanggal Order', value: '2020-02-10'),
          _item(context, title: 'Waktu Acara', value: '2023-12-25'),
          _item(context, title: 'Total Produk', value: '3x'),
          _item(context, title: 'Total Pembayaran', value: 'Rp. 300.000'),
          _item(context, title: 'Metode Pembayaran', value: 'Transfer Bank'),
          _item(context, title: 'Status Pesanan', value: 'Pending'),
          _item(context, title: 'Status Pembayaran', value: 'Pending'),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        Divider(color: XColors.primary),
      ],
    );
  }
}
