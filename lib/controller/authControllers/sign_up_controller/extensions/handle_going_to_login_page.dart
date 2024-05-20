import 'package:get/get.dart';

import '../../../../view/screens/auth/login_page.dart';
import '../sign_up_controller.dart';

extension HandleGoingToLoginPageExtension on SignUpController {
  void handleGoingToLoginPage() {
    print(Get.previousRoute);
    
    // Eğer önceki sayfa "/getStarted" ise LoginPage'e git, değilse bir önceki sayfaya geri dön.
    Get.previousRoute == "/getStarted" ? Get.to(LoginPage()) : Get.back();
  }
}
