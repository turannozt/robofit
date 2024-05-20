import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';

import '../controller/authControllers/newAuthStateChangeListener.dart';
import '../controller/functionsController/dialogsAndLoadingController.dart';

// GetX Yapısı: InitialBinding Sınıfı
class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Bu sınıf, uygulamanın başlangıcında kullanılacak temel bağımlılıkları yönetir.

    // Yeni kimlik durumu dinleyici kontrolcüsünü ekleyin
    Get.put<NewAuthStateChangeListener>(NewAuthStateChangeListener());

    // Uygulama boyunca kullanılacak FunctionsController'ı ekleyin.
    // permanent: true, bu controller'ın uygulama yaşam döngüsü boyunca var olacağını belirtir.
    Get.put<FunctionsController>(FunctionsController(), permanent: true);

    // Dialog ve yüklenme durumu kontrolcüsünü ekleyin
    Get.put<DialogsAndLoadingController>(DialogsAndLoadingController());
  }
}
