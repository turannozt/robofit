import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Firebase projenizin özel ayarlarını içeren dosya
import '../../firebase_options.dart';

// Uygulama başlangıcı için genel metotlar
class MainMethods {
  // Uygulama başlatma işlemlerini gerçekleştiren statik bir metot
  static Future<void> init() async {
    // Flutter binding'ini başlat
    WidgetsFlutterBinding.ensureInitialized();

    // Firebase'in başlatılması
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Ekran yönlendirmesini sadece portre moduna ayarla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
