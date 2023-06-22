import 'package:fani_wedding/component/ComponentButton.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/component/input.dart';
import 'package:fani_wedding/page/PageSignIn.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PageSignUp extends StatefulWidget {
  static String routeName = "/PageSignUp";
  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  TextEditingController emailController = TextEditingController();
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();
  TextEditingController kataSandiController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

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
                SizedBox(
                  height: 60.h,
                ),
                CircleAvatar(
                  radius: 90.r,
                  child: Image.asset("assets/apps/logo.png"),
                ),
                Center(
                  child: ComponentTextPrimaryTittleBold(
                    teks: "Daftar Akun",
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
                      teks: "Username",
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
                      teks: "Alamat",
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: Icon(Icons.my_location),
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
                  controller: kataSandiController,
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
                ComponentButtonPrimaryOutlineWithFunction(
                    "Daftar",
                    () async => {
                          UtilApi.register(
                              usernameController.text.toString(),
                              emailController.text.toString(),
                              noTeleponController.text.toString(),
                              kataSandiController.text.toString(),
                              alamatController.text.toString())
                        }),
                SizedBox(
                  height: 10.h,
                ),
                ComponentButtonPrimaryWithFunction(
                    "Masuk", () => {Get.toNamed(PageSignIn.routeName)}),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
