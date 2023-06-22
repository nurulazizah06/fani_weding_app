import 'dart:convert';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/ComponentButton.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/component/XAlertDialog.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/controller/ProductController.dart';
import 'package:fani_wedding/model/ModelKeranjang.dart';
import 'package:fani_wedding/page/BaseNavigation.dart';
import 'package:fani_wedding/page/PageDetailLayanan.dart';
import 'package:fani_wedding/page/PageKeranjangSaya.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/Util.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import '../model/ModelOrder.dart';

class PageRingkasanBelanja extends StatefulWidget {
  static String? routeName = "/PageRingkasanBelanja";

  @override
  State<PageRingkasanBelanja> createState() => _PageRingkasanBelanjaState();
}

class _PageRingkasanBelanjaState extends State<PageRingkasanBelanja> {
  final accountController = Get.put(AccountController());

  final productController = Get.put(ProductController());

  TextEditingController _usernameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController textEditingController = TextEditingController();
  String? address;
  TextEditingController _addressController = TextEditingController();

  Future<List<ModelKeranjang>> fetchKeranjangByCustId(String? custId) async {
    final url = Uri.parse('http://${UtilApi.ipName}/api/keranjang/${custId}');
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

  @override
  void initState() {
    super.initState();

    fetchKeranjangByCustId(accountController.account.value.idakun.toString())
        .then((list) {
      setState(() {
        listKeranjang = list;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  int jumlahProduct = 0;
  int totalHargaKeranjang = 0;
  void updateTotalHarga() {
    for (int i = 0; i < listKeranjang.length; i++) {
      jumlahProduct += listKeranjang[i].quantity!.toInt();
      totalHargaKeranjang += listKeranjang[i].price!.toInt();
    }
  }

  List<ModelKeranjang> listKeranjang = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    totalHargaKeranjang = 0;
    jumlahProduct = 0;
    updateTotalHarga();
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          Order order;
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ComponentTextPrimaryDescriptionBold(
                        teks: "Ringkasan Belanja",
                        size: SizeApp.SizeTextHeader + 10,
                      ),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                    color: ColorApp.primary,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ComponentTextPrimaryTittleBold(
                              teks: "Produk Belanja",
                              colorText: Colors.white,
                              size: SizeApp.SizeTextHeader.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: ListView.builder(
                              itemCount: listKeranjang.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: ComponentTextPrimaryTittleRegular(
                                        teks: "${listKeranjang[index].name}",
                                        colorText: Colors.white,
                                        size: SizeApp.SizeTextHeader.sp,
                                      ),
                                    ),
                                    ComponentTextPrimaryTittleBold(
                                      teks: UtilFormat.formatPrice(
                                          listKeranjang[index].price!.toInt()),
                                      colorText: Colors.white,
                                      size: SizeApp.SizeTextHeader.sp,
                                    ),
                                    
                                  ],
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ComponentTextPrimaryTittleRegular(
                                        teks: "Total",
                                        colorText: Colors.black,
                                        size: SizeApp.SizeTextHeader.sp,
                                      ),
                                    ),
                                    ComponentTextPrimaryTittleBold(
                                      teks: UtilFormat.formatPrice(
                                          totalHargaKeranjang),
                                      colorText: Colors.black,
                                      size: SizeApp.SizeTextHeader.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 20),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                onPressed: () {
                                  Get.toNamed(
                                      ProductCartView.routeName.toString());
                                },
                                child: ComponentTextPrimaryDescriptionRegular(
                                  teks: "Lihat Keranjang",
                                  size: SizeApp.SizeTextHeader.sp,
                                  colorText: Colors.black,
                                )),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ComponentTextPrimaryDescriptionBold(
                        teks: "Informasi Anda",
                        colorText: Colors.black,
                        size: SizeApp.SizeTextHeader.sp,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.person),
                                  ComponentTextPrimaryDescriptionBold(
                                    teks: accountController
                                        .account.value.username
                                        .toString(),
                                    colorText: Colors.black,
                                    size: SizeApp.SizeTextHeader - 3.sp,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.call),
                                  ComponentTextPrimaryDescriptionBold(
                                    teks: accountController
                                        .account.value.phoneNumber
                                        .toString(),
                                    colorText: Colors.black,
                                    size: SizeApp.SizeTextHeader - 3.sp,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.email),
                                  ComponentTextPrimaryDescriptionBold(
                                    teks: accountController.account.value.email
                                        .toString(),
                                    colorText: Colors.black,
                                    size: SizeApp.SizeTextHeader - 3.sp,
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                  ColorApp.primary,
                                )),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Edit Informasi Akun'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: _usernameController,
                                              decoration: InputDecoration(
                                                labelText: 'Username',
                                                prefixIcon: Icon(Icons.person),
                                              ),
                                            ),
                                            TextField(
                                              controller: _phoneController,
                                              decoration: InputDecoration(
                                                labelText: 'Telepon',
                                                prefixIcon: Icon(Icons.phone),
                                              ),
                                            ),
                                            TextField(
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                labelText: 'Email',
                                                prefixIcon: Icon(Icons.email),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Batal'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                accountController.account.value
                                                        .email.value =
                                                    _emailController.text
                                                        .toString();
                                                accountController.account.value
                                                        .phoneNumber.value =
                                                    _phoneController.text
                                                        .toString();
                                                accountController.account.value
                                                        .email.value =
                                                    _emailController.text
                                                        .toString();
                                              });

                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Simpan'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: ComponentTextPrimaryDescriptionRegular(
                                  teks: "Edit Informasi",
                                  size: SizeApp.SizeTextHeader - 2.sp,
                                  colorText: Colors.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ComponentTextPrimaryDescriptionBold(
                        teks: "Alamat",
                        colorText: Colors.black,
                        size: SizeApp.SizeTextHeader.sp,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_searching),
                                  address.isNullOrEmpty() == true
                                      ? ComponentTextPrimaryDescriptionBold(
                                          teks: "Inputkan Alamat Anda",
                                          colorText: Colors.black,
                                          size: SizeApp.SizeTextHeader - 3.sp,
                                        )
                                      : ComponentTextPrimaryDescriptionBold(
                                          teks: "${address} ",
                                          colorText: Colors.black,
                                          size: SizeApp.SizeTextHeader - 3.sp,
                                        )
                                ],
                              ),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        ColorApp.primary)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Inputkan Alamat Anda'),
                                        content: TextField(
                                          controller: _addressController,
                                          decoration: InputDecoration(
                                            labelText: 'Alamat',
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Batal'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Akses nilai alamat yang diinput
                                              setState(() {
                                                address =
                                                    _addressController.text;
                                              });

                                              // Lakukan aksi dengan nilai alamat
                                              // Misalnya: Simpan alamat ke database
                                              print('Alamat: $address');
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Simpan'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: ComponentTextPrimaryDescriptionRegular(
                                  teks: "Alamat",
                                  size: SizeApp.SizeTextHeader - 2.sp,
                                  colorText: Colors.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ComponentTextPrimaryDescriptionBold(
                    teks: "Waktu Acara",
                    colorText: Colors.black,
                    size: SizeApp.SizeTextHeader.sp,
                  ),
                  DateTextField(
                    controller: textEditingController,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ComponentTextPrimaryDescriptionBold(
                    teks: "Metode Pembayaran",
                    colorText: Colors.black,
                    size: SizeApp.SizeTextHeader.sp,
                  ),
                  PaymentMethodTextField(controller: _paymentMethodController),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      ComponentTextPrimaryDescriptionBold(
                        teks: "Total:",
                        colorText: Colors.black,
                        size: SizeApp.SizeTextHeader.sp,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      ComponentTextPrimaryDescriptionBold(
                        teks: UtilFormat.formatPrice(totalHargaKeranjang),
                        colorText: Colors.black,
                        size: SizeApp.SizeTextHeader.sp,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ComponentButtonPrimaryWithFunction(
                    "Order",
                    () => {
                      if (_addressController.value.text.toString().isEmpty || 
                          textEditingController.text.toString().isEmpty)
                        {Get.snackbar("Mohon Maaf", "Data Tidak Boleh Kosong")}
                      else
                        {
                          order = Order(
                            customerId: accountController
                                .account.value.idakun.value
                                .toInt(),
                            name: accountController.account.value.username.value
                                .toString(),
                            number: accountController
                                .account.value.phoneNumber.value
                                .toInt(),
                            email: accountController.account.value.email.value
                                .toString(),
                            method: _paymentMethodController.text.toString(),
                            address: _addressController.text.toString(),
                            totalProducts: jumlahProduct,
                            totalPrice: totalHargaKeranjang,
                            orderTime: getFormattedDateTime(),
                            eventTime: textEditingController.text.toString(),
                          ),
                          order.submitOrder(),
                          for (int i = 0; i < listKeranjang.length; i++)
                            {deleteKeranjang(listKeranjang[i].id!.toInt())},
                          Get.snackbar(
                              "Pesanan Berhasil", "Berhasil Melakukan Order"),
                          Get.toNamed(BaseNavigation.routeName.toString())
                        }
                    },
                    colorButton: ColorApp.primary,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> deleteKeranjang(int id) async {
    final String url =
        'http://${UtilApi.ipName}/api/keranjang_hapus/$id'; // Ganti dengan URL API Anda
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      // Hapus berhasil
      print('Customer account deleted successfully');
    } else {
      // Gagal menghapus
      print('Failed to delete customer account');
    }
  }

  String getFormattedDateTime() {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    return formattedDateTime;
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

TextEditingController _paymentMethodController = TextEditingController();

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
        size: 20.sp,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorApp.primary,
          minimumSize: Size.fromHeight(55.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r))),
    );
  }
}

class PaymentMethodTextField extends StatefulWidget {
  final TextEditingController controller;

  PaymentMethodTextField({required this.controller});

  @override
  _PaymentMethodTextFieldState createState() => _PaymentMethodTextFieldState();
}

class _PaymentMethodTextFieldState extends State<PaymentMethodTextField> {
  String selectedPaymentMethod = 'BCA:3320468646(An. Fani Sulistiowati)';

  @override
  void initState() {
    super.initState();
    widget.controller.text = selectedPaymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Pilih Metode Pembayaran'),
              content: DropdownButton<String>(
                value: selectedPaymentMethod,
                items: [
                  DropdownMenuItem(
                    value: 'BCA:3320468646(An. Fani Sulistiowati)',
                    child: Text('BCA:3320468646(An. Fani Sulistiowati)'),
                  ),
                  DropdownMenuItem(
                    value: 'Metode Pembayaran Lainnya',
                    child: Text('Metode Pembayaran Lainnya'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                    widget.controller.text = selectedPaymentMethod;
                  });
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
      decoration: InputDecoration(
        labelText: 'Metode Pembayaran',
      ),
    );
  }
}

class DateTextField extends StatefulWidget {
  final TextEditingController controller;

  DateTextField({required this.controller});

  @override
  _DateTextFieldState createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () async {
        await _selectDate(context);
        await _selectTime(context);

        final DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        final formattedDateTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime);
        widget.controller.text = formattedDateTime;
      },
      decoration: InputDecoration(
        label: ComponentTextPrimaryTittleRegular(
          teks: "Waktu Acara",
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(Icons.calendar_today ),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
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
