import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:work_out/config/Colors.dart';

class DialogsAndLoadingController extends GetxController {
  // Yükleniyor diyalogu
  showLoading() {
    Get.defaultDialog(
      title: "",
      backgroundColor: Colors.transparent,
      content: SpinKitSpinningLines(
        color: AppColors.green,
        duration: const Duration(seconds: 1),
        size: 80,
      ),
    );
  }

  // Onaylı işlemler içeren diyalog
  showConfirmWithActions(
    String infoText,
    String actionButtonText,
    void Function()? function,
  ) {
    Get.defaultDialog(
        title: "",
        backgroundColor: const Color(0xff131429),
        content: Column(
          children: [
            const Icon(
              Icons.warning,
              color: Color(0xff40D876),
              size: 60,
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 200,
              child: Text(
                infoText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text(
              "Geri",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            onPressed: function,
            child: Text(
              actionButtonText,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ]);
  }

  // Hata diyalogu
  showError(String errorText) {
    Get.defaultDialog(
        title: "",
        backgroundColor: const Color(0xff131429),
        content: Column(
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: Text(
                errorText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }

  // Başarı diyalogu
  showSuccess(String successText) {
    Get.defaultDialog(
      title: "",
      backgroundColor: const Color(0xff131429),
      content: Column(
        children: [
          const Icon(
            Icons.done,
            color: Color(0xff40D876),
            size: 60,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: Text(
              successText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
