// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../functionsController/dialogsAndLoadingController.dart';

class SignOutController extends GetxController {
  // Bağımlılık enjeksiyonu
  DialogsAndLoadingController dialogsAndLoadingController =
      Get.put(DialogsAndLoadingController());

  // Uygulamadan çıkış yapma
  signOut() async {
    try {
      // Yükleniyor göster
      dialogsAndLoadingController.showLoading();

      // Çıkış yapma metodu
      await FirebaseAuth.instance.signOut();

      // Başarılı olduğunda AuthStateController'ın işini yapması için pop'a gerek yoktur
    } on FirebaseAuthException catch (e) {
      // Hata durumunda önce pop yap
      Get.back();

      // Kullanıcıya hatayı göster
      dialogsAndLoadingController.showError("Error: ${e.code}");
    }
  }
}
