import 'package:get/get.dart';

class Account {
  RxString username;
  RxString email;
  RxString phoneNumber;
  RxString idakun;
  RxString address;

  Account({
    required String username,
    required String email,
    required String phoneNumber,
    required String idakun,
    required String address,
  })  : username = username.obs,
        email = email.obs,
        phoneNumber = phoneNumber.obs,
        idakun = idakun.obs,
        address = address.obs;

  Account.fromJson(Map<String, dynamic> json)
      : username = RxString(json['username']),
        email = RxString(json['email']),
        phoneNumber = RxString(json['phoneNumber']),
        idakun = RxString(json['idakun']),
        address = RxString(json['address']);

  Map<String, dynamic> toJson() {
    return {
      'username': username.value,
      'email': email.value,
      'phoneNumber': phoneNumber.value,
      'idakun': idakun.value,
      'address': address.value,
    };
  }
}

class LoginResponse {
  final String message;
  final String username;
  final String email;
  final String phoneNumber;
  final String idakun;
  final String address;

  LoginResponse({
    required this.message,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.idakun,
    required this.address,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      idakun: json['idakun'],
      address: json['address'],
    );
  }
}
