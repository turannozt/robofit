import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebasecore;
import '../../helpers/string_methods.dart';
import '../functionsController/dialogsAndLoadingController.dart';

class UserInformationController extends GetxController {
  // Dependency injection
  FunctionsController controller = Get.put(FunctionsController());
  DialogsAndLoadingController dialogsAndLoadingController =
      Get.put(DialogsAndLoadingController());

  // Variables
  // Username if some problem happened getting the username from user himself
  late RxString username = "Anonym username".obs;
  late RxString name = "Name".obs;
  late RxString mail = "Mail".obs;
  late RxString role = "role".obs;
  late RxString uid = "uid".obs;

  late RxString boy = "boy".obs;
  late RxString kilo = "kilo".obs;
  late RxString yas = "yas".obs;

  // Default img url
  RxString userProfileImg =
      "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile.png".obs;

  String? newGettedPath;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final storage = FirebaseStorage.instance;

  // ImgPicker instance
  ImagePicker picker = ImagePicker();

  // Set username from firestore ( accept string )
  setUsername() async {
    // Assign getted username from firestore to username variable
    username.value = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["username"],
        );
  }

  setName() async {
    // Assign getted name from firestore to name variable
    name.value = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["fullName"],
        );
  }

  setBoy() async {
    // Assign getted name from firestore to name variable
    boy.value = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["boy"],
        );
  }

  setKilo() async {
    // Assign getted name from firestore to name variable
    kilo.value = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["kilo"],
        );
  }

  setYas() async {
    // Assign getted name from firestore to name variable
    yas.value = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["yas"],
        );
  }

  setUid() async {
    // Assign getted name from firestore to name variable
    uid.value = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["uid"],
        );
  }

  setRole() async {
    // Assign getted name from firestore to name variable
    role.value = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["role"],
        );
  }

  setMail() async {
    // Assign getted name from firestore to name variable
    mail.value = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["email"],
        );
  }

  Future<String> getProfileImgPathFromFirestore() async {
    return await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (value) => value["profilePic"],
        ) as String;
  }

//profil yolunu ayarlama
  setProfileImgPath() async {
    // Set the getted profile img path from firestore to newGettedPath variable
    newGettedPath = await getProfileImgPathFromFirestore();

    // Checks if the there is difference between the newGettedPath and the userProfileImg from firestore
    bool isNewGettedPathDifferentThanUserProfileImg =
        (newGettedPath != userProfileImg.value);

    // Set it to userProfileImg variable if there is difference
    if (isNewGettedPathDifferentThanUserProfileImg && newGettedPath != "") {
      userProfileImg.value = newGettedPath!;
    }
  }

//kamerya erişim
  Future<XFile?> getImgFromCamera() async {
    // Get img from camera
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    // Check if there is img
    bool isImgPicked = image != null;

    // return it if there is img
    if (isImgPicked) {
      return image;
    }

    // Show error if there is no img
    dialogsAndLoadingController.showError(
      capitalize(
        "işlem iptal edildi",
      ),
    );
    return null;
  }

// resim fonksiyonu
  Future<XFile?> getImgFromDevice() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    bool isImgPicked = image != null;

    if (isImgPicked) {
      return image;
    }
    dialogsAndLoadingController.showError(
      capitalize(
        "işlem iptal edildi",
      ),
    );
    return null;
  }

  // profil resmi güncelle
  updateProfile(XFile? image) async {
    bool isImgPickedFromDeviceOrCamera = image != null;

    final Reference userProfileImgReference =
        storage.ref("usersProfileImgs/${_auth.currentUser!.uid}");

    late String imageDownloadURL;
    //
    if (isImgPickedFromDeviceOrCamera) {
      File imgFile = File(image.path);

      try {
        dialogsAndLoadingController.showLoading();

        await userProfileImgReference.putFile(imgFile);

        imageDownloadURL = await userProfileImgReference.getDownloadURL();

        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .update({
          "profilePic": imageDownloadURL,
        });

        userProfileImg.value = imageDownloadURL;

        Get.back();

        dialogsAndLoadingController.showSuccess(
          capitalize(
            "profil resmi başarıyla güncellendi",
          ),
        );
      } on firebasecore.FirebaseException catch (e) {
        Get.back();

        dialogsAndLoadingController.showError("$e");
      }
    } else {
      print("canceled");
    }
  }

  // kullanıcı adı güncelle
  updateUsername(String newUsername) async {
    dialogsAndLoadingController.showLoading();

    try {
      await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "username": newUsername,
      });

      Get.back();

      username.value = newUsername;

      dialogsAndLoadingController
          .showSuccess(capitalize("kullanıcı adı başarıyla güncellendi"));
    } on FirebaseException catch (e) {
      dialogsAndLoadingController.showError("${e.message}");
    }
  }

  // Boy güncelle
  updateBoy(String newBoy) async {
    dialogsAndLoadingController.showLoading();

    try {
      await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "boy": newBoy,
      });

      Get.back();

      boy.value = newBoy;

      dialogsAndLoadingController
          .showSuccess(capitalize("Boyunuz başarıyla güncellendi"));
    } on FirebaseException catch (e) {
      dialogsAndLoadingController.showError("${e.message}");
    }
  }

  // Kilo güncelle
  updateKilo(String newKilo) async {
    dialogsAndLoadingController.showLoading();

    try {
      await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "kilo": newKilo,
      });

      Get.back();

      kilo.value = newKilo;

      dialogsAndLoadingController
          .showSuccess(capitalize("Kilonuz başarıyla güncellendi"));
    } on FirebaseException catch (e) {
      dialogsAndLoadingController.showError("${e.message}");
    }
  }

  // Yaş güncelle
  updateYas(String newYas) async {
    dialogsAndLoadingController.showLoading();

    try {
      await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "yas": newYas,
      });

      Get.back();

      yas.value = newYas;

      dialogsAndLoadingController
          .showSuccess(capitalize("Yaşınız başarıyla güncellendi"));
    } on FirebaseException catch (e) {
      dialogsAndLoadingController.showError("${e.message}");
    }
  }

  updateName(String newName) async {
    dialogsAndLoadingController.showLoading();

    try {
      await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "fullName": newName,
      });

      Get.back();

      username.value = newName;

      dialogsAndLoadingController
          .showSuccess(capitalize("Adınız başarıyla güncellendi"));
    } on FirebaseException catch (e) {
      dialogsAndLoadingController.showError("${e.message}");
    }
  }

  // email güncelle
  updateEmail(String newEmail) async {
    dialogsAndLoadingController.showLoading();

    try {
      await _auth.currentUser!.updateEmail(newEmail);

      // ! after next opening of the app it'll demand to verify new email
      await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "email": newEmail,
        "verified": _auth.currentUser!.emailVerified,
      });
      Get.back();

      dialogsAndLoadingController.showSuccess(
        capitalize(
          "e-posta güncellemeleri başarıyla",
        ),
      );
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'requires-recent-login') {
        dialogsAndLoadingController.showConfirmWithActions(
            "Güvenlik nedeniyle, e-postayı değiştirme izni almak için hesabınıza yakın zamanda yeniden giriş yapmanız gerekiyor",
            capitalize("re-login"), () {
          _auth.signOut();
        });
      } else {
        dialogsAndLoadingController.showError(e.toString());
      }
    }
  }

// şifre güncelle
  updatePassword(String newPassword) async {
    dialogsAndLoadingController.showLoading();
    try {
      await _auth.currentUser!.updatePassword(newPassword);

      await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "password": newPassword,
      });

      Get.back();

      dialogsAndLoadingController.showSuccess(
        capitalize(
          "şifre güncellemeleri başarıyla",
        ),
      );
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'requires-recent-login') {
        dialogsAndLoadingController.showConfirmWithActions(
            "Güvenlik nedenlerinden dolayı, şifre değiştirme izni almak için hesabınıza yakın zamanda yeniden giriş yapmanız gerekmektedir.",
            capitalize("re-login"), () {
          _auth.signOut();
        });
      } else if (e.code == 'weak-password') {
        dialogsAndLoadingController.showError(capitalize("zayıf şifre"));
      } else {
        dialogsAndLoadingController.showError(e.toString());
      }
    }
  }

  // Kullanıcı Sil
  deleteUser() async {
    dialogsAndLoadingController.showLoading();
    try {
      await _auth.currentUser?.delete();

      dialogsAndLoadingController.showSuccess(capitalize("kullanıcı silindi"));
    } on FirebaseException catch (e) {
      Get.back();

// Same as above updateEmail method
      if (e.code == 'requires-recent-login') {
        dialogsAndLoadingController.showConfirmWithActions(
            "Güvenlik nedenlerinden dolayı, şifre değiştirme izni almak için hesabınıza yakın zamanda yeniden giriş yapmanız gerekmektedir.",
            capitalize("re-login"), () {
          _auth.signOut();
        });
      }
      // Other checks
      else if (e.code == 'weak-password') {
        dialogsAndLoadingController.showError(capitalize("zayıf şifre"));
      } else {
        dialogsAndLoadingController.showError(e.toString());
      }
    }
  }

  @override
  void onInit() {
    setUsername();
    setProfileImgPath();
    setMail();
    setName();
    setRole();
    setUid();
    setBoy();
    setKilo();
    setYas();
    super.onInit();
  }
}
