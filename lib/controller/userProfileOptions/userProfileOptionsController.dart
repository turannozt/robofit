// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/view/widgets/general_widgets/button.dart';
import 'package:work_out/view/widgets/general_widgets/text%20field.dart';

import '../../helpers/string_methods.dart';
import '../functionsController/dialogsAndLoadingController.dart';
import '../userController/userController.dart';

class UserProfileOptionsController extends GetxController {
  FunctionsController controller = Get.put(FunctionsController());
  UserInformationController userInformationController = Get.put(
    UserInformationController(),
  );
  DialogsAndLoadingController dialogsAndLoadingController =
      Get.put(DialogsAndLoadingController());
  TextEditingController newUserNameController = TextEditingController();
  TextEditingController newNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  //boy kilo yas
  TextEditingController newBoyController = TextEditingController();
  TextEditingController newKiloController = TextEditingController();
  TextEditingController newYasController = TextEditingController();
  late List userProfileOptionsList = [
    {
      "optionTitle": "kullanıcı adı değiştir",
      "optionIcon": Icons.person,
      "optionFunction": () {
        Get.bottomSheet(
          Container(
            width: double.infinity,
            height: 200,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                    label: capitalize("Yeni kullanıcı adı"),
                    controller: newUserNameController,
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: 50,
                  child: CustomButton(
                      text: capitalize("Güncelle"),
                      isOutlined: false,
                      onPressed: () {
                        Get.back();
                        userInformationController
                            .updateUsername(newUserNameController.text.trim());
                      }),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xff131429),
        );
      }
    },
    {
      "optionTitle": "Adınızı Değiştirin",
      "optionIcon": Icons.edit,
      "optionFunction": () {
        Get.bottomSheet(
          Container(
            width: double.infinity,
            height: 200,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                    label: capitalize("Yeni Adınız"),
                    controller: newNameController,
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: 50,
                  child: CustomButton(
                      text: capitalize("Güncelle"),
                      isOutlined: false,
                      onPressed: () {
                        Get.back();
                        userInformationController.role == "Antrenor"
                            ? userInformationController.updateName(
                                'Antrenör ${newNameController.text.trim()}')
                            : userInformationController
                                .updateName(newNameController.text.trim());
                      }),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xff131429),
        );
      }
    },
    {
      "optionTitle": "Boy, Kilo ve Yaş Güncelle",
      "optionIcon": Icons.update,
      "optionFunction": () {
        Get.bottomSheet(
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      label: capitalize("Boyunuzu Giriniz"),
                      controller: newBoyController,
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: CustomButton(
                      text: capitalize("Güncelle"),
                      isOutlined: false,
                      onPressed: () {
                        Get.back();
                        userInformationController
                            .updateBoy(newBoyController.text.trim());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                      label: capitalize("Yaşınızı Giriniz"),
                      controller: newYasController,
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: CustomButton(
                      text: capitalize("Güncelle"),
                      isOutlined: false,
                      onPressed: () {
                        Get.back();
                        userInformationController
                            .updateYas(newYasController.text.trim());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    label: capitalize("Kilonuzu Giriniz"),
                    controller: newKiloController,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: CustomButton(
                      text: capitalize("Güncelle"),
                      isOutlined: false,
                      onPressed: () {
                        Get.back();
                        userInformationController
                            .updateKilo(newKiloController.text.trim());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Color(0xff131429),
        );
      }
    },
    {
      "optionTitle": "profil resmi",
      "optionIcon": Icons.image,
      "optionFunction": () {
        Get.bottomSheet(
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    capitalize("Fotoğraf Seç"),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await userInformationController.updateProfile(
                              await userInformationController
                                  .getImgFromDevice());
                        },
                        child: Icon(
                          Icons.perm_media,
                          size: 55,
                          color: Color(0xff40D876),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await userInformationController.updateProfile(
                              await userInformationController
                                  .getImgFromCamera());
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 55,
                          color: Color(0xff40D876),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: Color(0xff131429));
      },
    },
    {
      "optionTitle": "şifreyi değiştir",
      "optionIcon": Icons.lock,
      "optionFunction": () {
        Get.bottomSheet(
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                      obscureText: true,
                      label: capitalize("Yeni Şifre"),
                      controller: newPasswordController,
                      keyboardType: TextInputType.visiblePassword),
                  SizedBox(
                    height: 50,
                    child: CustomButton(
                        text: capitalize("Güncelle"),
                        isOutlined: false,
                        onPressed: () async {
                          Get.back();
                          await userInformationController.updatePassword(
                              newPasswordController.text.trim());
                        }),
                  )
                ],
              ),
            ),
            backgroundColor: Color(0xff131429));
      }
    },
    {
      "optionTitle": "hesabımı sil",
      "optionIcon": Icons.delete,
      "optionFunction": () {
        dialogsAndLoadingController.showConfirmWithActions(
          capitalize("Hesabın silmek istedğinden emin misin ?"),
          capitalize("Sil"),
          () {
            Get.back();
            userInformationController.deleteUser();
          },
        );
      }
    },
  ];
}
