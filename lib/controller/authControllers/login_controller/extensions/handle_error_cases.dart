import 'package:work_out/controller/authControllers/login_controller/login_controller.dart';

import '../../../../config/text.dart';
import '../../../../helpers/string_methods.dart';

extension ErrorHandlesExtension on LoginController {
  void handleErrorCases(e) {
    // Ağ hatası kontrolü
    if (e.code == 'network-request-failed') {
      // Kullanıcıya internet bağlantısını kontrol etmesi gerektiğini söyleyen hata bildirimi göster
      dialogsAndLoadingController
          .showError(capitalize(AppTexts.checkConnection));
    }

    // Kullanıcı bulunamadığı durumu kontrolü
    if (e.code == 'user-not-found') {
      // Kullanıcıya böyle bir kullanıcı bulunamadığını söyleyen hata bildirimi göster
      dialogsAndLoadingController.showError(AppTexts.noUserText);
    } else if (e.code == 'wrong-password') {
      // Yanlış şifre girişi durumu kontrolü
      // Kullanıcıya yanlış şifre girdiğini söyleyen hata bildirimi göster
      dialogsAndLoadingController.showError(capitalize(AppTexts.wrongPassword));
    } else {
      // Diğer tüm hata durumları için genel hata kodunu göster
      dialogsAndLoadingController.showError(e.code);
    }
  }
}
