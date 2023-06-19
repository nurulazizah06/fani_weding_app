import 'dart:convert';
import 'dart:io';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:fani_wedding/component/ComponentText.dart';
import 'package:fani_wedding/controller/AccountController.dart';
import 'package:fani_wedding/model/ModelKeranjang.dart';

import 'package:fani_wedding/model/ModelRIwayat.dart';
import 'package:fani_wedding/util/ColorApp.dart';
import 'package:fani_wedding/util/SizeApp.dart';
import 'package:fani_wedding/util/Util.dart';
import 'package:fani_wedding/util/UtilAPI.dart';
import 'package:fani_wedding/util/XColors.dart';
import 'package:fani_wedding/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class PageOrder extends StatefulWidget {
  static String? routeName = "/PageOrder";
  @override
  State<PageOrder> createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {
  Future<List<ModelRiwayatOrder>> getOrderHistory(String name) async {
    final url = Uri.parse('http://${UtilApi.ipName}/api/orders-show/$name');
    final response = await http.get(url);
    print("http://${UtilApi.ipName}/orders-show/$name repsonse = " +
        response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      List<ModelRiwayatOrder> orderList =
          jsonList.map((json) => ModelRiwayatOrder.fromJson(json)).toList();
      return orderList;
    } else {
      throw Exception('Failed to fetch order history');
    }
  }

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

  List<ModelRiwayatOrder> listRiwayat = [];

  List<ModelKeranjang> listKeranjang = [];
  final controllerAccount = Get.put(AccountController());
  @override
  void initState() {
    super.initState();

    fetchKeranjangByCustId(controllerAccount.account.value.idakun.toString())
        .then((list) {
      setState(() {
        listKeranjang = list;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getOrderHistory(controllerAccount.account.value.idakun.toString())
        .then((list) {
      setState(() {
        listRiwayat = list;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return ListView(
            shrinkWrap: true,
            physics: PageScrollPhysics(),
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
                          icon: Stack(children: [
                            HeroIcon(
                              HeroIcons.shoppingCart,
                              color: Colors.white,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    "${listKeranjang.length}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                            )
                          ]))
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: PageScrollPhysics(),
                itemBuilder: (context, index) {
                  return OrderItem(listRiwayat[index]);
                },
                itemCount: listRiwayat.length,
              )
            ],
          );
        },
      ),
    );
  }
}

class NotaDialog extends StatelessWidget {
  final String fromName;
  final String fromAddress;
  final String fromPhone;
  final String fromEmail;
  final String toName;
  final String toAddress;
  final String toEmail;
  final String metodePembayaran;
  final String productName;
  final double harga;
  final int jumlah;

  NotaDialog({
    required this.fromName,
    required this.fromAddress,
    required this.fromPhone,
    required this.fromEmail,
    required this.toName,
    required this.toAddress,
    required this.toEmail,
    required this.metodePembayaran,
    required this.productName,
    required this.harga,
    required this.jumlah,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nota Tagihan'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From:'),
            Text('$fromName $fromAddress'),
            Text('Phone: $fromPhone'),
            Divider(),
            Text('Email: $fromEmail'),
            Divider(), // Divider added
            Text('To:'),
            Text('$toName $toAddress'),
            Text('Email: $toEmail'),
            Divider(), // Divider added
            Text('Metode Pembayaran: $metodePembayaran'),
            Divider(), // Divider added

            Text('Total Produk: ${jumlah}'),

            Divider(), // Divider added
            Text('Total Harga: ${UtilFormat.formatPrice(harga.toInt())}'),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Tutup'),
        ),
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  OrderItem(this.order);
  final ModelRiwayatOrder order;
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
          _item(context, title: 'Nama', value: order.name.toString()),
          _item(context, title: 'Email', value: order.email.toString()),
          _item(context,
              title: 'Nomor Telepon', value: order.number.toString()),
          _item(context, title: 'Alamat', value: order.address.toString()),
          _item(context,
              title: 'Tanggal Order', value: order.orderTime.toString()),
          _item(context,
              title: 'Waktu Acara', value: order.eventTime.toString()),
          _item(context,
              title: 'Total Produk', value: order.totalProducts.toString()),
          _item(context,
              title: 'Total Pembayaran',
              value: UtilFormat.formatPrice(order.totalPrice!.toInt())),
          _item(context,
              title: 'Metode Pembayaran', value: order.method.toString()),
          _item(context,
              title: 'Status Pesanan',
              value: order.orderStatus.toString() == "null"
                  ? "pending"
                  : "diterima"),
          _item(context,
              title: 'Status Pembayaran',
              value: order.paymentStatus.toString() == "null"
                  ? "pending"
                  : "setujui"),
          order.paymentStatus.toString() == "setujui"
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bukti Pembayaran"),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => NotaDialog(
                                  fromName: 'Fani Sulistiowati',
                                  fromAddress:
                                      'JJL Mangga Karang Templek Ambulu, Kabputen Jember',
                                  fromPhone: '08215166129',
                                  fromEmail: 'FannyManyun26@gmail.com',
                                  toName: order.name.toString(),
                                  toAddress: order.address.toString(),
                                  toEmail: order.email.toString(),
                                  metodePembayaran: 'BCA :33204677',
                                  productName: 'List Produk',
                                  harga: order.totalPrice!.toDouble(),
                                  jumlah: order.totalProducts.toInt(),
                                ),
                              );
                            },
                            child: Text("Cetak Nota"))
                      ],
                    ),
                    Divider(color: XColors.primary),
                  ],
                )
              : order.orderStatus.toString() == "null"
                  ? Container()
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Bukti Pembayaran"),
                            ElevatedButton(
                                onPressed: () {
                                  _pickImage(
                                      ImageSource.gallery,
                                      order.id.toString(),
                                      order.customerId.toString());
                                },
                                child: Text("Upload Bukti Pembayaran"))
                          ],
                        ),
                        Divider(color: XColors.primary),
                      ],
                    )
        ],
      ),
    );
  }

  File? _image;
  String? _namaFile;
  Future _pickImage(ImageSource source, String idOrder, String custId) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);

      _image = img;
      // Random random = Random();
      // String namaFileBaru = "profile${random.nextInt(1000)}";
      // String pathBaru =
      //     Path.join(Path.dirname(_image.toString()), namaFileBaru);
      _namaFile = Path.basename(_image.toString());
      if (_namaFile != null) {
        sendRequestWithFile(file: img, id_order: idOrder, custId: custId);
      }
      // Navigator.of(context).pop();
    } on PlatformException catch (e) {
      print("eror gambar :: ${e}");
      // Navigator.of(context).pop();
    }
  }

  Future<void> updateOrderImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      var url = Uri.parse('http://${UtilApi.ipName}/api/orders-image');

      var request = http.MultipartRequest('PUT', url);

      request.files.add(
        await http.MultipartFile.fromPath('image', pickedImage.path),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Gambar berhasil diupdate');
      } else {
        print('Gagal mengupdate gambar. Kode status: ${response.statusCode}');
      }
    }
  }
}

Future<int> sendRequestWithFile(
    {String? id_order, File? file, String? custId}) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse("http://${UtilApi.ipName}/api/oderuploadtransaksi"));

  // tambahkan text sebagai field pada request

  request.fields['id'] = id_order.toString();
  request.fields['id_cust'] = custId.toString();

  // tambahkan file sebagai field pada request
  var mimeType = lookupMimeType(file!.path);
  var fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
  var fileLength = await file.length();
  var multipartFile = http.MultipartFile(
    'file',
    fileStream,
    fileLength,
    filename: file.path.split('/').last,
    contentType: MediaType.parse(mimeType!),
  );
  request.files.add(multipartFile);

  // kirim request dan tunggu responsenya
  var response = await http.Response.fromStream(await request.send());
  print(response.body.toString() + "cok");
  return response.statusCode;
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
          SizedBox(
            width: 150,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      Divider(color: XColors.primary),
    ],
  );
}
