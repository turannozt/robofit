import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/login_controller/extensions/text.dart';

import '../../functionsController/dialogsAndLoadingController.dart';

class LoginController extends GetxController {
  // Giriş bilgileri için text editing controller'ları
  late TextEditingController loginEmailController;
  late TextEditingController loginPasswordController;

  // Bağımlılık enjeksiyonu
  DialogsAndLoadingController dialogsAndLoadingController = Get.find();

  // Şifre alanının gösterilip gizlenmesini yöneten bir metot eklenebilir

  @override
  void onInit() {
    // Text editing controller'ları başlatma işlemi
    initializeTextEditingControllers();
    super.onInit();
  }

  @override
  void onClose() {
    // Text editing controller'ları yok etme (dispose) işlemi
    disposeTextEditingControllers();
    super.onClose();
  }
}
