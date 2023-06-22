import 'dart:convert';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/ComponentButton.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/component/input.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/model/ModelAccount.dart';
import 'package:fani_wedding/page/BaseNavigation.dart';
import 'package:fani_wedding/page/PageSignIn.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';

import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PageEditAkun extends StatefulWidget {
  static String routeName = "/PageEditAkun";
  @override
  State<PageEditAkun> createState() => _PageEditAkunState();
}

class _PageEditAkunState extends State<PageEditAkun> {
  TextEditingController emailController = TextEditingController();
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final accountController = Get.put(AccountController());

  TextEditingController usernameController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          usernameController.text =
              accountController.account.value.username.value;
          noTeleponController.text =
              accountController.account.value.phoneNumber.value.toString();
          emailController.text =
              accountController.account.value.email.value.toString();
          alamatController.text =
              accountController.account.value.address.value.toString();
          return Padding(
            padding: EdgeInsets.only(left: 10.h, right: 10.h),
            child: ListView(
              children: [
                Center(
                  child: ComponentTextPrimaryTittleBold(
                    teks: "Edit Akun",
                    size: SizeApp.SizeTextHeader + 10.sp,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextField(
                  controller: usernameController,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    // Handle email input
                  },
                  decoration: InputDecoration(
                    label: ComponentTextPrimaryTittleRegular(
                      teks: "Nama",
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(Icons.abc),
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
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextField(
                  controller: emailController,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    // Handle email input
                  },
                  decoration: InputDecoration(
                    label: ComponentTextPrimaryTittleRegular(
                      teks: "Email",
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(Icons.email),
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
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextField(
                  controller: noTeleponController,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    // Handle email input
                  },
                  decoration: InputDecoration(
                    label: ComponentTextPrimaryTittleRegular(
                      teks: "Nomor Telepon",
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(Icons.phone),
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
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextField(
                  controller: alamatController,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    // Handle email input
                  },
                  decoration: InputDecoration(
                    label: ComponentTextPrimaryTittleRegular(
                      teks: "Alamat Akun",
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(Icons.location_searching),
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
                ),
                SizedBox(
                  height: 40.h,
                ),
                ComponentButtonPrimaryWithFunction(
                    "Simpan",
                    () async => {
                          updateCustomer(
                              accountController.account.value.idakun.value
                                  .toInt(),
                              usernameController.text.toString(),
                              emailController.text.toString(),
                              noTeleponController.text.toString(),
                              alamatController.text.toString()),
                          Get.toNamed(BaseNavigation.routeName.toString())
                        }),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> updateCustomer(int id, String? name, String? email,
      String? number, String? address) async {
    Account accounts = Account(
        idakun: id.toString(),
        username: name.toString(),
        email: email.toString(),
        phoneNumber: number.toString(),
        address: address.toString());
    accountController.account.value = accounts;
    accountController.saveAccount();
    final customerData = {
      'name': name,
      'email': email,
      'number': email,
      'address': address,
    };
    final url =
        Uri.parse('http://${UtilApi.ipName}/api/customer_accounts-update/$id');

    final response = await http.put(
      url,
      body: jsonEncode(customerData),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body + "cok i");
    if (response.statusCode == 200) {
      final customer = jsonDecode(response.body);
      print('Customer updated: $customer');
    } else {
      print('Failed to update customer. Error code: ${response.statusCode}');
    }
  }
}
