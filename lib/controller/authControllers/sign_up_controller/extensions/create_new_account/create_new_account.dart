import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/sign_up_controller/extensions/create_new_account/add_user_info_to_firestore.dart';
import 'package:work_out/controller/authControllers/sign_up_controller/extensions/create_new_account/sign_up_catched_error.dart';
import 'package:work_out/helpers/extension/user_info_validator_extension.dart';

import '../../../../../config/text.dart';
import '../../../../../helpers/string_methods.dart';
import '../../../../../view/screens/auth/EmailVerification.dart';
import '../../sign_up_controller.dart';

extension CreateNewAccExtension on SignUpController {
  /// Firebase auth üzerinde yeni bir hesap oluşturur, ardından kimlik bilgilerini, uid'yi, oluşturma zamanını, e-posta doğrulama durumunu vb. ek bilgileri ekler.
  Future<void> createNewAccount({
    required String email,
    required String password,
    required String username,
    required String name,
    required String role,
  }) async {
    if (email.isValidEmail &&
        password.isValidPassword &&
        username.isAcceptedUsername) {
      try {
        dialogsAndLoadingController.showLoading();

        // Firebase hesap oluşturma yöntemi, kimlik bilgisini saklar
        final UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Burada sadece e-posta ve şifre ile Firebase auth ile hesap oluşturduk, daha fazla veri toplamak ve kullanmak için bunu saklamamız gerekiyor
        addUserInformationToFirestore(
          role: role,
          name: name,
          credential: credential,
          email: email,
          username: username,
          isEmailVerified: FirebaseAuth.instance.currentUser!.emailVerified,
          uid: credential.user!.uid,
          profileImgPath: "",
          boy: "0",
          kilo: "0",
          yas: "0",
          // password: password,
        );

        // Hesap oluşturulduğunda, kullanıcı e-posta adresini doğrulamalıyız (gereksiz kontrol gereksizdir)
        Get.to(() => EmailVerificatioPage());
      } on FirebaseAuthException catch (e) {
        Get.back();
        handleErrorCases(e);
      } catch (e) {
        dialogsAndLoadingController.showError(
          capitalize(
            e as String,
          ),
        );
      }
    }

    // Şimdi, eğer bir şey geçerli değilse, kullanıcıya bilgi verin
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      dialogsAndLoadingController.showError(
        capitalize(
          AppTexts.fillFields,
        ),
      );
    } else if (!username.isAcceptedUsername) {
      dialogsAndLoadingController.showError(
        capitalize(
          AppTexts.usernameMustBe5AtLeast,
        ),
      );
    } else if (!email.isValidEmail) {
      dialogsAndLoadingController.showError(
        capitalize(
          AppTexts.invalidEmail,
        ),
      );
    } else if (!password.isValidPassword) {
      dialogsAndLoadingController.showError(
        capitalize(
          AppTexts.passwordMustBe5AtLeast,
        ),
      );
    }
  }
}
