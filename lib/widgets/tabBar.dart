import 'package:flutter/material.dart';
import '../size_config.dart';
import '../app_theme.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    Key key,
    @required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      height: 80,
      color: MyTheme.kPrimaryColor,
      child: TabBar(
        controller: tabController,
        indicator: ShapeDecoration(
            color: MyTheme.kAccentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        tabs: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Tab(
              // iconMargin: EdgeInsets.symmetric(horizontal: 20),
              icon: Icon(Icons.chat, size: getText(30)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Tab(
              // iconMargin: EdgeInsets.symmetric(horizontal: 20),
              icon: Icon(
                Icons.people,
                size: getText(35),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Tab(
              // iconMargin: EdgeInsets.symmetric(horizontal: 20),
              icon: Icon(
                Icons.person_add,
                size: getText(35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
