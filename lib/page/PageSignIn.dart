import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/ComponentButton.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/component/XAlertDialog.dart';
import 'package:fani_wedding/component/input.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/model/ModelAccount.dart';
import 'package:fani_wedding/page/BaseNavigation.dart';
import 'package:fani_wedding/page/PageDaftar.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PageSignIn extends StatefulWidget {
  static String routeName = "/PageSignIn";
  @override
  State<PageSignIn> createState() => _PageSignInState();
}

class _PageSignInState extends State<PageSignIn> {
  TextEditingController emailController = TextEditingController();
  final accountController = Get.put(AccountController());
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void performLogin(String email, String password) async {
    try {
      final loginResponse = await UtilApi.login(email, password);

      Get.snackbar("Berhasil Login", "Email Dan Password Anda Benar");
      print('Message: ${loginResponse.message}');
      print('Username: ${loginResponse.username}');
      print('Email: ${loginResponse.email}');
      print('Phone Number: ${loginResponse.phoneNumber}');
      print("id Akun:  ${loginResponse.idakun}");
      Account accounts = Account(
          idakun: loginResponse.idakun,
          username: loginResponse.username,
          email: loginResponse.email,
          phoneNumber: loginResponse.phoneNumber);
      accountController.account.value = accounts;
      accountController.saveAccount();
      Get.offAndToNamed(BaseNavigation.routeName.toString());
      print(accounts.username.value); // Output: John Doe
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return XAlertDialog(
            title: "Login Gagal",
            content: "Email dan password yang anda massukan salah",
          );
        },
      );
      print('Error anj: $e');
    }
  }

  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.only(left: 10.h, right: 10.h),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () =>
                          {Get.toNamed(BaseNavigation.routeName.toString())},
                      icon: Icon(Icons.arrow_back)),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 100.r,
                    backgroundImage: AssetImage("assets/apps/logo.png"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: ComponentTextPrimaryTittleBold(
                    teks: "Masuk Sekarang",
                    size: SizeApp.SizeTextHeader + 10.sp,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextField(
                  controller: textEditingControllerEmail,
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
                  controller: textEditingControllerPassword,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    // Handle password input
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    label: Text(
                      "Password",
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: GestureDetector(
                      onTap: _togglePasswordVisibility,
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                ComponentButtonPrimaryWithFunction(
                    "Masuk",
                    () => {
                          performLogin(textEditingControllerEmail.text,
                              textEditingControllerPassword.text)
                        }),
                SizedBox(
                  height: 10.h,
                ),
                ComponentButtonPrimaryOutlineWithFunction("Daftar",
                    () => {Get.toNamed(PageSignUp.routeName.toString())})
              ],
            ),
          );
        },
      ),
    );
  }
}
