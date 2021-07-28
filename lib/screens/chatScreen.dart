import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../counterState.dart';

import '../models/message.dart';
import '../models/user.dart';
import '../size_config.dart';
import '../widgets/conversation.dart';
import '../app_theme.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  final function;
  const ChatScreen({Key key, @required this.user, this.function});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController text = new TextEditingController();
  List msg = messages;
  Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyTheme.kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            height: getHeight(100),
            padding: EdgeInsets.symmetric(
                vertical: getHeight(7), horizontal: getWidth(20)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => {Get.back()},
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                    size: getText(20),
                  ),
                ),
                Text(
                  widget.user.name[0].toUpperCase() +
                      widget.user.name.substring(1),
                  style: GoogleFonts.montserrat(
                      fontSize: getText(28),
                      letterSpacing: getText(4),
                      color: Colors.white),
                ),
                widget.function != null
                    ? GestureDetector(
                        onTap: () {
                          Get.back();
                          widget.function(widget.user);
                        },
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: getText(25),
                        ),
                      )
                    : SizedBox(
                        width: getWidth(20),
                      )
              ],
            )),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: messages != null
                  ? Conversation(messages: List.from(messages.reversed))
                  : Container(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: getHeight(20), left: getWidth(20), right: getWidth(20)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(14)),
                    height: getHeight(60),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(getText(30)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message ...',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.camera_enhance,
                            color: Colors.grey[500],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    if (text.text != "") {
                      Message msg = Message(
                          body: text.text,
                          sent: Timestamp.now(),
                          status: 0,
                          from: controller.user.name);
                      setState(() {
                        messages.add(msg);
                        text.clear();
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: getWidth(30),
                    backgroundColor: MyTheme.kAccentColor,
                    child: Container(
                      padding: EdgeInsets.only(left: getWidth(4)),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
