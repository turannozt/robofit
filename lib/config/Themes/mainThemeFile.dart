import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Uygulamanın genel temalarını içeren dosyalar
import '../../view/widgets/general_widgets/customMaterialColor.dart';
import '../Colors.dart';
import 'inputDecoration.dart';

// Uygulamanın ana temasını oluşturan sınıf
class MainTheme {
  // Giriş dekorasyonları
  static final inputDecoration = inputDecorationTheme;

  // Tema oluşturucu, bir BuildContext alır
  MainTheme(this.context);

  // BuildContext nesnesi
  late BuildContext context;

  // Tema verilerini içeren ThemeData nesnesi
  late ThemeData themeData = ThemeData(
    // Google Fonts kullanarak metin temalarını ayarla
    textTheme: GoogleFonts.notoSansTextTheme(
      Theme.of(context).textTheme,
    ),

    // Renk şemalarını ayarla
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: colorCustom,
    ),

    // Giriş dekorasyon temasını ayarla
    inputDecorationTheme: MainTheme.inputDecoration,

    // Primay renk
    primaryColor: AppColors.green,
  );
}
