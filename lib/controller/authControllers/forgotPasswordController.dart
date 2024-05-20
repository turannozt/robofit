// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:work_out/config/text.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/controller/functionsController/dialogsAndLoadingController.dart';

import '../../helpers/string_methods.dart';

class ForgotPasswordController extends GetxController {
  // Bağımlılık enjeksiyonu
  FunctionsController controller = Get.put(FunctionsController());
  DialogsAndLoadingController dialogsAndLoadingController =
      Get.put(DialogsAndLoadingController());

  // Metin düzenleme denetleyicileri
  late TextEditingController emailToRecoverPassword;

  // Şifreyi kurtarma yöntemi
  recoverPassword(String email) async {
    // E-postanın geçerli olup olmadığını kontrol et
    bool isValidEmail = emailRegExp.hasMatch(email);

    // Eğer geçerliyse

    // email != '' isteğe bağlıdır, ancak kaldıramam (bu mükemmeliyet sendromuna denir)
    if (isValidEmail && email != '') {
      try {
        // Yükleme ekranını göster
        dialogsAndLoadingController.showLoading();

        // İstek gönder (bağımsız bir örnek yapmaya gerek yok)
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        // Başarı durumunda yükleme ekranını kapat
        Get.back();

        // Kullanıcıya başarıyı göster
        dialogsAndLoadingController
            .showSuccess(capitalize(AppTexts.emailVerifSentText));

        //
      } on FirebaseAuthException catch (e) {
        // hata durumunda önce yükleme ekranını kapat
        Get.back();

        // Hata kontrol (daha spesifik olmak istiyorsanız her hataya özel bir durum yapın) bu modelde
        if (e.code == "user-not-found") {
          dialogsAndLoadingController
              .showError(capitalize(AppTexts.noUserText));
        }
        // burada kendi kontrol ettiğiniz hatalar
        else {
          dialogsAndLoadingController.showError("$e.message");
        }
      }
      // bu isteğe bağlıdır
      catch (e) {
        dialogsAndLoadingController.showError(e.toString());
      }
    }
    // e-posta kontrolleri ()
    else if (email == "") {
      dialogsAndLoadingController.showError(capitalize(AppTexts.enterEmail));
    } else if (!isValidEmail) {
      dialogsAndLoadingController
          .showError(capitalize(AppTexts.enterValidEmail));
    }
  }

  @override
  void onInit() {
    // Giriş denetleyici beyanları
    emailToRecoverPassword = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // Giriş denetleyici atıkları
    emailToRecoverPassword.dispose();
    super.onClose();
  }
}
