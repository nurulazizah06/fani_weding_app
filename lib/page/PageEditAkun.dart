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

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordlamaController = TextEditingController();
  TextEditingController passwordbaruController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();

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
                  controller: noTeleponController,
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
                  height: 10.h,
                ),
                TextField(
                  controller: passwordlamaController,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    // Handle password input
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    label: Text(
                      "Masukan Kata Sandi Baru",
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
                  height: 10.h,
                ),
                TextField(
                  controller: passwordbaruController,
                  onTap: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    // Handle password input
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    label: Text(
                      "Konfirmasi Kata Sandi Baru",
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
                    "Simpan",
                    () async => {
                          UtilApi.register(
                              usernameController.text.toString(),
                              emailController.text.toString(),
                              noTeleponController.text.toString(),
                              passwordbaruController.text.toString())
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
