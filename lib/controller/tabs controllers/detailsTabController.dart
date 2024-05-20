import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Detaylar sekmesi kontrolcüsü
  late TabController detailsTabController;

  // Gösterilecek sekmeler
  final List<Tab> detailsTabs = <Tab>[
    const Tab(text: "Açıklama"),
    const Tab(text: "Değerlendirmeler"),
    const Tab(text: 'Yorumlar'),
  ];

  @override
  void onInit() {
    // onInit metodunda başlatılır
    detailsTabController =
        TabController(vsync: this, length: detailsTabs.length);
    super.onInit();
  }

  @override
  void onClose() {
    // Kapatıldığında (dispose)
    detailsTabController.dispose();
    super.onClose();
  }
}
