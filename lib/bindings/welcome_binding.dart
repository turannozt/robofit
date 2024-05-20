import 'package:get/get.dart';

// GetX Yapısı: WelcomePageBinding Sınıfı
class WelcomePageBinding implements Bindings {
  @override
  void dependencies() {
    // Bu sınıf, hoş geldiniz sayfasındaki bağımlılıkları yönetir.
    // Şu an için herhangi bir bağımlılık eklenmemiştir.

    // Eğer sayfa için bir controller ya da başka bir bağımlılık ekleyecekseniz,
    // bu kısıma ilgili Get.put ifadesini ekleyebilirsiniz.
    // Örneğin:
    // Get.put<FunctionsController>(FunctionsController());
  }
}
