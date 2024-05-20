import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:work_out/controller/authControllers/sign_up_controller/sign_up_controller.dart';

extension AddExtraInfoExt on SignUpController {
  /// Kullanıcı hakkında daha fazla bilgiyi veritabanına ekler. Not: Kullanıcının gizliliği için şifreyi eklememelisiniz, ancak isterseniz ekleyebilirsiniz.
  Future<void> addUserInformationToFirestore({
    required UserCredential credential,
    required String role,
    required String email,
    required String name,
    required String username,
    required String profileImgPath,
    required String uid,
    required bool isEmailVerified,
    String? password,
    required String boy,
    required String kilo,
    required String yas,
  }) async {
    // uid'ye göre eklemeyi yap
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "role": role,
      "email": email,
      "fullName": name,
      // Kullanıcının gizliliği için şifreyi almanın bir nedeni yoktur, veritabanında saklamayın
      "password": password ?? "",
      "username": username,
      "groups": [],
      "profilePic": profileImgPath,
      "uid": credential.user!.uid,
      "verified": isEmailVerified,
      "createdAt": thisMomentTime,
      "boy": boy,
      "kilo": kilo,
      "yas": yas,
    });
  }
}
