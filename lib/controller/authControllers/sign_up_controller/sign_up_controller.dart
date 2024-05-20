import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/sign_up_controller/extensions/text_editing_controller_lifecycle.dart';
import '../../functionsController/dialogsAndLoadingController.dart';

class SignUpController extends GetxController {
  // DialogsAndLoadingController'ı al
  final DialogsAndLoadingController dialogsAndLoadingController = Get.find();

  // Anlık zamanı al (kullanıcı hakkında daha fazla bilgi almak için)
  FieldValue thisMomentTime = FieldValue.serverTimestamp();

  // Input controller'ları
  late TextEditingController signUpNameController,
      signUpUserController,
      signUpEmailController,
      signUpPasswordController;

  // İlk oluşturulduğunda çalışacak metot
  @override
  void onInit() {
    initializeTextEditingControllers();
    super.onInit();
  }

  // Kontrolcü kapatıldığında çalışacak metot
  @override
  void onClose() {
    disposeTextEditingControllers();
    super.onClose();
  }
}
