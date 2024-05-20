import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../config/text.dart';
import '../helpers/string_methods.dart';
import '../view/screens/user profile/components/appBar.dart';
import 'model_class.dart';
import 'second_page.dart';
import 'widget.dart';

class HomePageHard extends StatefulWidget {
  const HomePageHard({super.key});

  @override
  State<HomePageHard> createState() => _HomePageHardState();
}

class _HomePageHardState extends State<HomePageHard> {
  final String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A";

  List<Exercise> allData = [];
  late Exercise exercise;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  bool isLoading = false;

  fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response = await http.get(Uri.parse(link));
      debugPrint("Status code is ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (var i in data["exercises"]) {
          exercise = Exercise(
            id: i["id"],
            title: i["title"],
            thumbnail: i["thumbnail"],
            seconds: i["seconds"],
            gif: i["gif"],
          );

          setState(() {
            allData.add(exercise);
          });
        }

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint("the problem is $e");
      showToast("Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      blur: 0.5,
      opacity: 0.5,
      progressIndicator: spinkit,
      child: Scaffold(
        backgroundColor: const Color(0xff0A0C23).withOpacity(0.5),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text(
            capitalize("Antrenman Zor"),
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
        body: listView(),
      ),
    );
  }

  ListView listView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      reverse: true,
      itemCount: 15,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset.fromDirection(2.0, 4.0),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff0A0C23), width: 2),
                image: DecorationImage(
                  image: NetworkImage("${allData[index].thumbnail}"),
                  fit: BoxFit.cover,
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.fromDirection(2.0, 4.0),
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: const Color(0xff0A0C23), width: 0.5),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                height: 40,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "${allData[index].title}",
                    style: myStyle(18, Colors.white60, FontWeight.w600),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              right: 35,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SecondPage(
                        exercise: allData[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xff0A0C23), width: 1),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          "Go",
                          style: myStyle(18, Colors.black, FontWeight.w600),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

TextStyle myStyle(double fontSize, Color color, [FontWeight? fontWeight]) {
  return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
}

void showToast(String message) {
  debugPrint(message);
}
