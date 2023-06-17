import 'package:fani_wedding/model/ModelAccount.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountController extends GetxController {
  final account =
      Account(username: '', email: '', phoneNumber: '', idakun: "0").obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadAccount();
  }

  void loadAccount() {
    final storedAccount = storage.read('account');
    if (storedAccount != null) {
      account(Account.fromJson(storedAccount));
    }
  }

  void saveAccount() {
    print("save berhasil");

    storage.write('account', account.value.toJson());
  }

  void clearAccount() {
    storage.remove('account');
    account(Account(username: '', email: '', phoneNumber: '', idakun: "0"));
  }
}
