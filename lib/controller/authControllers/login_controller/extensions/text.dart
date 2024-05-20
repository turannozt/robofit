import 'package:flutter/widgets.dart';
import 'package:work_out/controller/authControllers/login_controller/login_controller.dart';

extension TextEditingCtrlLifeCycleExt on LoginController {
  // Bu metot, text editing controller'ları yok eder (dispose)
  void _disposeTextEditingControllers() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
  }

  // Bu metot, text editing controller'ları başlatır (initialize)
  void _initializeTextEditingControllers() {
    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();
  }

  /// Bu fonksiyon, text editing controller'ları başlatma işlemini gerçekleştirir
  void Function() get initializeTextEditingControllers =>
      _initializeTextEditingControllers;

  /// Bu fonksiyon, text editing controller'ları yok etme (dispose) işlemini gerçekleştirir
  void Function() get disposeTextEditingControllers =>
      _disposeTextEditingControllers;
}

