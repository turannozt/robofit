import 'package:get/get.dart';

import '../controller/authControllers/login_controller/login_controller.dart';

// GetX Yapısı: LoginBinding Sınıfı
class LoginBinding implements Bindings {
  @override
  void dependencies() {
    // Bu sınıf, giriş sayfasındaki bağımlılıkları yönetir.

    // LoginController'ı ekleyin, bu controller sayfadaki işlevselliği kontrol eder.
    Get.put<LoginController>(LoginController());
  }
}
