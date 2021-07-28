import 'package:get/get.dart';
import '../counterState.dart';
import 'package:intl/intl.dart';
import '../size_config.dart';

import '../app_theme.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  const Conversation({
    Key key,
    @required this.messages,
  }) : super(key: key);
  final List messages;

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        itemCount: widget.messages.length,
        itemBuilder: (context, int index) {
          final message = widget.messages[index];
          bool isMe = message.from == controller.user.name;
          return Container(
            margin: EdgeInsets.only(top: getHeight(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: getWidth(10),
                    ),
                    Container(
                        padding: EdgeInsets.all(getWidth(10)),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6),
                        decoration: BoxDecoration(
                            color:
                                isMe ? MyTheme.kAccentColor : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(getText(16)),
                              topRight: Radius.circular(getText(16)),
                              bottomLeft:
                                  Radius.circular(isMe ? getText(12) : 0),
                              bottomRight:
                                  Radius.circular(isMe ? 0 : getText(12)),
                            )),
                        child: Text(
                          message.body,
                          style: MyTheme.bodyTextMessage.copyWith(
                              fontSize: getText(16),
                              color: isMe ? Colors.white : Colors.grey[800]),
                        )),
                  ],
                ),
                if (index == 0)
                  Padding(
                    padding: EdgeInsets.only(top: getHeight(5)),
                    child: Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        if (!isMe)
                          SizedBox(
                            width: getWidth(10),
                          ),
                        if (isMe)
                          message.status == null
                              ? Icon(
                                  Icons.lock_clock,
                                  size: getText(20),
                                  color: MyTheme.bodyTextTime.color,
                                )
                              : message.status == 1
                                  ? Icon(
                                      Icons.done_all,
                                      size: getText(20),
                                      color: Colors.blue,
                                    )
                                  : Icon(
                                      Icons.done,
                                      size: getText(20),
                                      color: MyTheme.bodyTextTime.color,
                                    ),
                        SizedBox(
                          width: getWidth(8),
                        ),
                        Text(
                          DateFormat.Hm().format(
                              DateTime.parse(message.sent.toDate().toString())),
                          style: MyTheme.bodyTextTime,
                        )
                      ],
                    ),
                  )
              ],
            ),
          );
        });
  }
}
