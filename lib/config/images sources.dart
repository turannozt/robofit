import 'dart:math';

// Yerel varlıkları (resimleri) içeren sınıf
class ImgSrc {
  ImgSrc();

  // Resim dosya yolları listesi
  List<String> imgList = <String>[
    ImgSrc.welcome,
    ImgSrc.getStarted,
    ImgSrc.login,
    ImgSrc.homepageOverlay,
  ];

  // Karşılık gelen resim dosya yolları
  static String welcome = 'imgs/welcomeOverlayImg.png';
  static String getStarted = 'imgs/GetStartedOverlay.png';
  static String login = 'imgs/loginOverlayImg.png';
  static String primaryLaungage = "imgs/en.png";
  static String secondaryLaungage = "imgs/fr.png";
  static String imgVerification = "imgs/email_verif.png";
  static String homepageOverlay = 'imgs/welcomePageOverlay.png';

  // Varsayılan resim yoksa kullanılan dosya yolu
  static String noImgAvailable = "imgs/No_image_available.png";

  // Rastgele bir resim dosya yolu seçme metodu
  String randomFromAssetsList() {
    return imgList[Random().nextInt(imgList.length)];
  }
}
