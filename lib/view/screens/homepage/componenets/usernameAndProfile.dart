// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../config/text.dart';
import 'avatar.dart';

class ProfileAndUsername extends StatelessWidget {
  ProfileAndUsername({
    super.key,
    required this.username,
    required this.profileImg,
    this.onProfileImgTap,
    required this.role,
  });

  String username;
  String profileImg;
  String role;
  void Function()? onProfileImgTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: role == "Antrenor" ? "Antrenör," : AppTexts.hey,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 25,
            ),
            children: [
              TextSpan(
                text: ' $username',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Avatar(
          onProfileImgTap: onProfileImgTap,
          networkImage: profileImg,
        ),
      ],
    );
  }
}
