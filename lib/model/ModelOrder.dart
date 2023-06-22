import 'dart:convert';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:http/http.dart' as http;

class Order {
  final int customerId;
  final String name;
  final int number;
  final String email;
  final String method;
  final String address;
  final int totalProducts;
  final int totalPrice;
  final String orderTime;
  final String eventTime;

  Order({
    required this.customerId,
    required this.name,
    required this.number,
    required this.email,
    required this.method,
    required this.address,
    required this.totalProducts,
    required this.totalPrice,
    required this.orderTime,
    required this.eventTime,
  });

  Future<void> submitOrder() async {
    final String url =
        'https://${UtilApi.ipName}/api/orders-add'; // Ganti dengan URL endpoint order di server Anda

    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> data = {
      'customer_id': customerId,
      'name': name,
      'number': number,
      'email': email,
      'method': method,
      'address': address,
      'total_products': totalProducts,
      'total_price': totalPrice,
      'order_time': orderTime,
      'event_time': eventTime,
      'proof_payment': "placeholder"
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    print(response.body + "response cok");
    if (response.statusCode == 200) {
      // Pesanan berhasil dikirim
      print('Pesanan berhasil dikirim');
    } else {
      // Gagal mengirim pesanan
      print('Gagal mengirim pesanan');
    }
  }
}
