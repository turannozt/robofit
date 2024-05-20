// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:work_out/admob/strings.dart';


class GoogleAds {
  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;
  RewardedAd? rewardedAd;

  /// Loads an interstitial ad.
  void loadInterstitialAd({bool showAfterLoad = false}) {
    final adUnitId = Platform.isAndroid
        ? KAdStrings.loadInterstitialAd_android
        : KAdStrings.loadInterstitialAd_ios;
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            if (showAfterLoad) showInterstitialAd();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.show();
    }
  }

  /// Loads a banner ad.
  void loadBannerAd({required VoidCallback adLoaded}) {
    final adUnitId = Platform.isAndroid
        ? KAdStrings.loadBannerAd_android
        : KAdStrings.loadBannerAd_ios;

    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          adLoaded();
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }


  /// Loads a  rewarded  ad.

  /// Loads a rewarded ad.
  void loadRewardedAd(
      {bool showAfterLoad = false, required VoidCallback adLoaded}) {
    final adUnitId = Platform.isAndroid
        ? KAdStrings.loadRewardedAd_android
        : KAdStrings.loadRewardedAd_ios;
    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            rewardedAd = ad;
            if (showAfterLoad) showInterstitialAd();
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
      );
    }
  }
  
}
