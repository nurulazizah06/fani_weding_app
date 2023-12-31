import 'dart:convert';
import 'package:fani_wedding/model/ModelAccount.dart';
import 'package:fani_wedding/page/BaseNavigation.dart';
import 'package:fani_wedding/page/PageSignIn.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UtilApi {
  static String? ipName = "wofy.my.id";
  static Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse(
        'https://${UtilApi.ipName}/api/login'); // Ganti dengan URL endpoint login API Anda

    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return LoginResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<void> register(String username, String email,
      String phoneNumber, String password, String alamat) async {
    final url = Uri.parse('https://${UtilApi.ipName}/api/register');

    final response = await http.post(
      url,
      body: jsonEncode({
        'name': username,
        'email': email,
        'number': phoneNumber,
        'password': password,
        'address': alamat
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      // Berhasil melakukan registrasi
      Get.snackbar("Register Berhasil", "Selamat AKun Anda Telah DiBuat");
      Get.offAndToNamed(PageSignIn.routeName.toString());

      print('Registration successful');
    } else {
      Get.snackbar(
          "Register Gagal", "Harap Cek Kembali Data Yang Anda Masukan");
      // Gagal melakukan registrasi
      print('Registration failed');
    }
  }
}
