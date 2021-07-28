import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../counterState.dart';
import '../models/message.dart';
import '../models/user.dart';
import '../screens/chatScreen.dart';
import '../size_config.dart';
import '../app_theme.dart';

class Chats extends StatefulWidget {
  final User user;
  final function;
  const Chats({@required this.user, @required this.function});

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  Controller controller = Get.find();
  String unreadCount = messages.length.toString();
  Message message = messages[0];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          widget.function(widget.user);
        },
        onTap: () {
          Get.to(() => ChatScreen(
                user: widget.user,
                function: widget.function,
              ));
        },
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: getWidth(15), vertical: getHeight(4)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
                vertical: getHeight(10), horizontal: getWidth(10)),
            height: getHeight(90),
            width: getWidth(400),
            child: Row(
              children: [
                CircleAvatar(
                  radius: getText(30),
                  backgroundImage: NetworkImage(widget.user.dp),
                ),
                SizedBox(
                  width: getWidth(20),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: getWidth(10),
                      ),
                      Text(
                        widget.user.name[0].toUpperCase() +
                            widget.user.name.substring(1),
                        style: MyTheme.heading2.copyWith(
                          fontSize: getText(16),
                        ),
                      ),
                      if (message != null)
                        Container(
                          width: getWidth(150),
                          child: Text(
                            message.body,
                            style: MyTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      SizedBox(
                        width: getWidth(10),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: getWidth(20),
                    ),
                    unreadCount != null && unreadCount != '0'
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(8),
                                vertical: getHeight(2)),
                            decoration: BoxDecoration(
                                color: MyTheme.kUnreadChatBG,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(getText(6)))),
                            child: Text(
                              unreadCount,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getText(11),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : SizedBox(
                            height: getHeight(10),
                          ),
                    Text(
                      DateFormat.Hm().format(
                          DateTime.parse(message.sent.toDate().toString())),
                      style: MyTheme.bodyTextTime,
                    ),
                  ],
                ),
              ],
            )));
  }
}
