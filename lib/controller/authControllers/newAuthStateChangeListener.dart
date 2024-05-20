// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:work_out/view/screens/auth/EmailVerification.dart';
import 'package:work_out/view/screens/welcome/welcome_page.dart';

import '../../view/screens/homepage/homePage.dart';

class NewAuthStateChangeListener extends GetxController {
  // FirebaseAuth örneği
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Null olabilen gözlemlenebilir bir Rxn<User?>
  Rxn<User?> user = Rxn<User?>(null);

  // Kullanıcı durumu işleyici
  void handleTheUserState(User? user) {
    if (user == null) {
      // Kullanıcı yok / kullanıcı oturumu kapatılmış
      Get.offAll(WelcomePage());
    } else {
      if (!user.emailVerified) {
        // Kullanıcı oturum açtı ancak e-posta doğrulanmadı
        Get.offAll(EmailVerificatioPage());
      } else {
        // Kullanıcı oturum açtı
        Get.offAll(HomePage());
      }
    }
  }

  @override
  void onReady() {
    // user'ı izle ve değişiklik olduğunda handleTheUserState fonksiyonunu çağır
    ever(user, handleTheUserState);

    // user'ı _auth.authStateChanges() akışına bağla
    user.bindStream(_auth.authStateChanges());
    super.onReady();
  }
}
