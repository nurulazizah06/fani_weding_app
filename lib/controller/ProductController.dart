import 'package:fani_wedding/model/ModelProduct.dart';
import 'package:fani_wedding/page/PageDetailLayanan.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxString kategoryName = "".obs;
  final productd = ProductResponse(
          id: 0, name: "", category: "", keterangan: "", price: "0", image: "")
      .obs;
}
