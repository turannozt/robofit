// ignore_for_file: file_names

import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:work_out/admob/service.dart';

import 'package:work_out/chatgpt/chatgpt.dart';

import 'package:work_out/config/Colors.dart';
import 'package:work_out/config/workouts%20lists/workouts%20Lists.dart';
import 'package:work_out/view/screens/user%20profile/userProfil.dart';

import '../../../chat/pages/home_page.dart';
import '../../../config/images sources.dart';
import '../../../controller/functionsController.dart';
import '../../../controller/tabs controllers/workOutTabController.dart';
import '../../../controller/userController/userController.dart';
import '../../../helpers/string_methods.dart';
import '../../widgets/general_widgets/screen_background_image.dart';
import 'componenets/find_your_workout.dart';
import 'componenets/playButton.dart';
import 'componenets/tabBarViewSections.dart';
import 'componenets/usernameAndProfile.dart';

//ana sayfa
class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  final String bgImg = ImgSrc().randomFromAssetsList();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FunctionsController controller = Get.put(FunctionsController());

  final UserInformationController userInformationController =
      Get.put(UserInformationController());

  final CustomTabBarController _tabx = Get.put(CustomTabBarController());
  final GoogleAds _googleAds = GoogleAds();

  @override
  void initState() {
    _googleAds.loadBannerAd(adLoaded: () => setState(() {}));
    _googleAds.loadInterstitialAd();
    _googleAds.loadRewardedAd(adLoaded: () => setState(() {}));

    Timer.periodic(const Duration(seconds: 5), (timer) {
      _googleAds.loadInterstitialAd();
    });

    Timer.periodic(const Duration(seconds: 5), (timer) {
      _googleAds.loadRewardedAd(
        adLoaded: () => setState(() {}),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(
            backgroundImage: 'imgs/logo.png',
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: const [0.45, 1],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.darkBlue,
                  AppColors.darkBlue.withOpacity(0.05),
                ],
              ),
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Obx(
                        () => ProfileAndUsername(
                          role: userInformationController.role.value,
                          onProfileImgTap: () {
                            Get.to(() => const UserProfile());
                          },
                          username: capitalize(
                            userInformationController.username.value,
                          ),
                          profileImg:
                              userInformationController.userProfileImg.value,
                        ),
                      ),
                      Spacer(),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delay + 200),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FindYourWorkout(),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: DelayedDisplay(
                          delay: Duration(
                            milliseconds: delay + 400,
                          ),
                          child: TabBar(
                            //padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
                            labelColor: Colors.white,
                            isScrollable: true,
                            unselectedLabelColor: Colors.grey,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            controller: _tabx.workOutTabController,
                            tabs: _tabx.workOutTabs,
                          ),
                        ),
                      ),
                      Expanded(
                        child: DelayedDisplay(
                          delay: Duration(milliseconds: delay + 600),
                          child: TabBarView(
                            controller: _tabx.workOutTabController,
                            children: [
                              Center(
                                child: TabBarViewSection(
                                  title: capitalize(
                                    'Tümü',
                                  ),
                                  dataList: WorkoutsList.allWorkoutsList,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const HomePageSS(),
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.chat_sharp,
                                    size: 48,
                                    color: Colors.white,
                                  )),
                              const Text(
                                'Grup',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ChatScreen(),
                                  ));
                                },
                                icon: Image.network(
                                  'https://cdn.discordapp.com/attachments/1240926161496703046/1242187956505149482/robot.png?ex=664ced2f&is=664b9baf&hm=feacc4a52aa5d9ad7b1a52e8b71d88a0a713fdd26367950e44a299f7cf6e14c6&',
                                  width: 60,
                                  height: 60,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'RoboFit',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
