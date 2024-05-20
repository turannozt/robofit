// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/Movements/home_page_easy.dart';

import '../controller/userController/userController.dart';
import 'model_class.dart';
import 'widget.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key? key, this.exercise, this.second}) : super(key: key);

  final Exercise? exercise;
  int? second;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late Timer timer;
  int startSound = 0;
  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //var dec = widget.second !-1;
      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          showToast("Workout Successfully Completed");
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        });
      }
      setState(() {
        startSound = timer.tick;
      });
    });

    super.initState();
  }

  final UserInformationController userInformationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0A0C23).withOpacity(0.7),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.close_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: const Text(
          "Bitir",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ClipOval(
              child:
                  Image.network(userInformationController.userProfileImg.value),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff0A0C23).withOpacity(0.7),
      body: Stack(
        children: [
          const SizedBox(
            height: 60,
          ),

          //Image.network("${widget.exercise!.gif}", height: double.infinity,),
          CachedNetworkImage(
            width: double.infinity,
            imageUrl: "${widget.exercise!.gif}",
            //fit: BoxFit.cover,
            height: double.infinity,
            placeholder: (context, url) => spinkit,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset.fromDirection(2.0, 4.0),
                            blurRadius: 3,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ],
                      ),
                      child: Text("$startSound",
                          style: myStyle(40, Colors.white, FontWeight.w600)),
                    ),
                    Text("Zaman Artıyor",
                        style: myStyle(25, Colors.white, FontWeight.w600)),
                    Text("$startSound"),
                  ],
                ),
              )),

          Positioned(
              left: 0,
              right: 0,
              bottom: 100,
              child: Center(
                  child: Text("${widget.exercise!.title}",
                      style: myStyle(25, Colors.white, FontWeight.w700)))),
          Positioned(
              left: 0,
              right: 0,
              bottom: 70,
              child: Center(
                  child: Text("Hareketi Üstteki Gibi Yapınız!",
                      style: myStyle(18, Colors.grey, FontWeight.w700)))),
        ],
      ),
    );
  }
}
