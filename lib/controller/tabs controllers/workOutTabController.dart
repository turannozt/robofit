import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Sekme denetleyicisi
  late TabController workOutTabController;

  // Gösterilecek sekmeler
  final List<Tab> workOutTabs = <Tab>[
    const Tab(text: ""),
 
  ];

  @override
  void onInit() {
    // onInit metodu başlatılır
    workOutTabController =
        TabController(vsync: this, length: workOutTabs.length);
    super.onInit();
  }

  @override
  void onClose() {
    // Kapatıldığında (dispose)
    workOutTabController.dispose();
    super.onClose();
  }
}
