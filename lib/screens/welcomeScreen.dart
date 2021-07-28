import 'package:get/get.dart';
import '../screens/homeScreen.dart';
import '../counterState.dart';

import '../size_config.dart';

import '../app_theme.dart';
import 'package:flutter/material.dart';

class WelcmScreen extends StatefulWidget {
  @override
  _WelcmScreenState createState() => _WelcmScreenState();
}

class _WelcmScreenState extends State<WelcmScreen> {
  TextEditingController org = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pin = TextEditingController();
  Controller controller = Get.find();
  TabController tabController;
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: getHeight(80)),
                child: Column(
                  children: [
                    Center(
                      child: Text('WELCOME',
                          style: TextStyle(
                              fontFamily: "Neptune",
                              fontSize: getText(40),
                              color: MyTheme.kPrimaryColor)),
                    ),
                    SizedBox(
                      height: getHeight(20),
                    ),
                    Center(
                      child: Text('- to -',
                          style: TextStyle(
                              fontFamily: "Neptune",
                              fontSize: getText(30),
                              color: MyTheme.kPrimaryColor)),
                    ),
                    SizedBox(
                      height: getHeight(20),
                    ),
                    Center(
                      child: Text('The Lounge',
                          style: TextStyle(
                              fontFamily: "Neptune",
                              fontSize: getText(40),
                              color: MyTheme.kPrimaryColor)),
                    ),
                    SizedBox(
                      height: getHeight(150),
                    ),
                    Center(
                      child: Text(controller.user.name ?? "Miriam",
                          style: TextStyle(
                              // fontFamily: "Neptune",
                              fontSize: getText(40),
                              color: MyTheme.kPrimaryColor)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Get.off(HomePage(), transition: Transition.downToUp);
            },
            child: Container(
              height: getHeight(120),
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              decoration: BoxDecoration(
                  color: MyTheme.kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getText(30)),
                    topRight: Radius.circular(getText(30)),
                  )),
              child: Center(
                child: Text("Enter",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getText(30),
                        fontFamily: "Neptune")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
