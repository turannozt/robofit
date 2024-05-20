import 'package:flutter/widgets.dart';
import 'package:work_out/controller/authControllers/sign_up_controller/sign_up_controller.dart';

extension TextEditingCtrlLifeCycleExt on SignUpController {
  // Bu metot, text editing controller'ları dispose eder.
  void _disposeTextEditingControllers() {
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpUserController.dispose();
    signUpNameController.dispose();
  }

  // Bu metot, text editing controller'ları initialize eder.
  void _initializeTextEditingControllers() {
    signUpNameController=TextEditingController();
    signUpUserController = TextEditingController();
    signUpEmailController = TextEditingController();
    signUpPasswordController = TextEditingController();
  }

  /// Bu metot, text editing controller'ları initialize etmek için kullanılır.
  void Function() get initializeTextEditingControllers =>
      _initializeTextEditingControllers;

  /// Bu metot, text editing controller'ları dispose etmek için kullanılır.
  void Function() get disposeTextEditingControllers =>
      _disposeTextEditingControllers;
}
