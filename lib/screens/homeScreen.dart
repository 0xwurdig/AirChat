import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user.dart';
import '../widgets/chat.dart';
import '../widgets/newCards.dart';
import '../widgets/requestCards.dart';
import '../widgets/sildeToConfirm.dart';

import '../size_config.dart';
import '../widgets/tabBar.dart';
import '../app_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;
  int currentTabIndex = 0;
  bool closeContainer = false;
  double topContainer = 0;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });
    controller.addListener(() {
      double value = controller.offset / getWidth(220 * 0.9);
      setState(() {
        topContainer = value;
        closeContainer = controller.offset > 20 ? true : false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> blockContact(User user) async {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: getHeight(20)),
        height: getHeight(200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(getText(20)),
              topRight: Radius.circular(getText(20))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: getWidth(300)),
              child: Text(
                "Do you want to block ${user.name}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: getText(24)),
              ),
            ),
            ConfirmationSlider(
              height: getHeight(70),
              backgroundShape: BorderRadius.circular(getText(10)),
              width: getWidth(260),
              foregroundColor: Colors.red[800],
              foregroundShape: BorderRadius.circular(getText(10)),
              text: "BLOCK",
              textStyle: TextStyle(fontSize: getText(20)),
              onConfirmation: () async {
                try {
                  setState(() {
                    users.remove(user);
                  });
                  Get.back();
                  Get.rawSnackbar(
                      snackPosition: SnackPosition.TOP,
                      messageText: Text("Deleted",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)));
                } catch (e) {
                  Get.rawSnackbar(
                      snackPosition: SnackPosition.TOP,
                      messageText: Text("Error! Please Try Again",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.kPrimaryColor,
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: closeContainer ? 0 : getHeight(150),
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              // height: getHeight(150),
              padding: EdgeInsets.only(top: 80),
              child: Center(
                child: Text(
                  'AI-A322',
                  style: GoogleFonts.bebasNeue(
                      fontSize: getText(50),
                      letterSpacing: 4,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: getHeight(40),
          ),
          MyTabBar(tabController: tabController),
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              // padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: TabBarView(
                controller: tabController,
                children: [
                  chat(users),
                  requests(users),
                  newPassengers(users),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget chat(List users) {
    return users.length > 0
        ? ListView(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            children: users.map((e) {
              return Chats(
                user: e,
                function: blockContact,
              );
            }).toList(),
          )
        : Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: Text(
                "Oops! You have no contacts added yet, add them?",
                style: TextStyle(fontSize: getText(24), color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }

  Widget newPassengers(List users) {
    return ListView.builder(
      controller: controller,
      itemCount: users.length,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        double scale = 1.0;
        if (topContainer > 0.5) {
          scale = index + 0.5 - topContainer;
          if (scale < 0) {
            scale = 0;
          } else if (scale > 1) {
            scale = 1;
          }
        }
        return Transform(
          transform: Matrix4.identity()..scale(scale, scale),
          alignment: Alignment.bottomCenter,
          child: Align(
            heightFactor: 0.8,
            alignment: Alignment.topCenter,
            child: NewCard(
              user: users[index],
            ),
          ),
        );
      },
    );
  }

  Widget requests(List users) {
    return ListView.builder(
      controller: controller,
      itemCount: users.length,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey<User>(users[index]),
          secondaryBackground: Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: getText(50),
                ),
              )),
          background: Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: getText(50),
                ),
              )),
          onDismissed: (direction) {
            setState(() {
              users.removeAt(index);
            });
          },
          child: RequestCard(
            user: users[index],
          ),
        );
      },
    );
  }
}
