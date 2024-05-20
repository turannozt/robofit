import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../config/text.dart';
import '../helpers/string_methods.dart';
import 'home_page_easy.dart';
import 'model_class.dart';
import 'third_page.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key, this.exercise}) : super(key: key);

  final Exercise? exercise;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int second = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0C23).withOpacity(0.5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          capitalize("Başla !"),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.network(
            "${widget.exercise!.thumbnail}",
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SleekCircularSlider(
                    min: 0,
                    max: 30,
                    initialValue: second.toDouble(),
                    onChange: (double value) {
                      setState(() {
                        second = value.toInt();
                      });
                    },
                    innerWidget: (double value) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              second.toStringAsFixed(0),
                              style:
                                  myStyle(35, Colors.orange, FontWeight.w700),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ThirdPage(
                                      exercise: widget.exercise,
                                      second: second,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink),
                              child: Text(
                                "Başla",
                                style: myStyle(16, Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "${widget.exercise!.title}",
              style: myStyle(25, Colors.white, FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
