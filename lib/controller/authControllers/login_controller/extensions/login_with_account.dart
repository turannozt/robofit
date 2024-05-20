import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/login_controller/extensions/handle_error_cases.dart';
import 'package:work_out/helpers/extension/user_info_validator_extension.dart';

import '../../../../chat/helper/helper_function.dart';
import '../../../../chat/service/database_service.dart';
import '../../../../config/text.dart';
import '../../../../helpers/string_methods.dart';
import '../login_controller.dart';

extension LoginWithAccountExtension on LoginController {
  /// Firebase e-posta/şifre yöntemi ile kimlik doğrulama işlemi
  Future<void> loginWithAccount({
    required String email,
    required String password,
  }) async {
    // İlk olarak, gelen e-posta ve şifre bilgilerinin doğruluğunu kontrol et
    if (email.isValidEmail && password.isValidPassword) {
      try {
        // Loading dialog göster
        dialogsAndLoadingController.showLoading();

        // Firebase'in signInWithEmailAndPassword metodu ile kimlik doğrulama işlemini gerçekleştir
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) async {
          if (value == true) {
            QuerySnapshot snapshot = await DatabaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);
            // saving the values to our shared preferences
            await HelperFunctions.saveUserLoggedInStatus(true);
            await HelperFunctions.saveUserEmailSF(email);
            await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          
          } else {
           
          }
        });

        // Loading dialogu kapatmaya gerek yok, çünkü eğer işlem başarılı olursa auth dinleyici zaten çalışacaktır
      } on FirebaseAuthException catch (e) {
        // Hata durumunda önce loading dialogu kapat
        Get.back();
        // Hata durumlarını işleyen handleErrorCases metodunu çağır
        handleErrorCases(e);
      }
    }

    // Eğer gelen giriş bilgileri uygun değilse, uygun hata bildirimlerini göster
    if (email.isEmpty) {
      dialogsAndLoadingController.showError(
        capitalize(AppTexts.enterEmail),
      );
    } else if (!email.isValidEmail) {
      dialogsAndLoadingController.showError(
        capitalize(AppTexts.invalidEmail),
      );
    } else if (password.isEmpty) {
      dialogsAndLoadingController.showError(
        capitalize(AppTexts.enterPassword),
      );
    } else if (!password.isValidPassword) {
      dialogsAndLoadingController.showError(
        capitalize(AppTexts.passwordMustBe5AtLeast),
      );
    }
  }
}
