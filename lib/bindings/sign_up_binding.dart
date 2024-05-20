import 'package:get/get.dart';

import '../controller/authControllers/sign_up_controller/sign_up_controller.dart';

// GetX Yapısı: SignUpBinding Sınıfı
class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    // Bu sınıf, kayıt olma sayfasındaki bağımlılıkları yönetir.

    // SignUpController'ı ekleyin, bu controller sayfadaki işlevselliği kontrol eder.
    Get.put<SignUpController>(SignUpController());
  }
}
