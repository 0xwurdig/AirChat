import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../size_config.dart';

import '../app_theme.dart';

class NewCard extends StatefulWidget {
  final User user;
  const NewCard({@required this.user});
  @override
  _NewCardState createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  bool add = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38.withOpacity(0.5),
                  blurRadius: getText(18),
                  spreadRadius: getText(1))
            ],
          ),
          padding: EdgeInsets.symmetric(
              vertical: getHeight(10), horizontal: getWidth(10)),
          height: getHeight(220),
          width: getWidth(400),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: getText(50),
                  backgroundImage: NetworkImage(widget.user.dp),
                ),
                SizedBox(
                  width: getWidth(10),
                ),
                Container(
                  width: getWidth(160),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(widget.user.name,
                          overflow: TextOverflow.ellipsis,
                          style: MyTheme.bodyTextMessage.copyWith(
                            fontSize: getText(16),
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: getHeight(7),
                      ),
                      Text(widget.user.designation,
                          overflow: TextOverflow.ellipsis,
                          style: MyTheme.bodyTextMessage.copyWith(
                            fontSize: getText(15),
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                      Text(widget.user.company,
                          overflow: TextOverflow.ellipsis,
                          style: MyTheme.bodyTextMessage.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: getText(12),
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        add = !add;
                      });
                    },
                    child: Container(
                        // color: Colors.red,
                        width: getWidth(35),
                        height: getHeight(35),
                        child: FlareActor(
                          "assets/add-close.flr",
                          animation: add ? "add_to_close" : "close_to_add",
                          fit: BoxFit.fill,
                          color: add ? Colors.red : MyTheme.kAccentColor,
                        )),
                  ),
                  SizedBox(height: getHeight(8)),
                  Text(!add ? " Tap to add " : "      Undo      ",
                      overflow: TextOverflow.ellipsis,
                      style: MyTheme.bodyTextMessage.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: getText(10),
                        color: !add ? Colors.black : Colors.red,
                      )),
                ])
              ],
            ),
            SizedBox(
              height: getHeight(10),
            ),
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.transparent,
                  ],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                height: getHeight(80),
                padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.transparent),
                child: Text(widget.user.bio,
                    softWrap: true,
                    // overflow: TextOverflow.ellipsis,
                    style: MyTheme.bodyTextMessage.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: getText(12),
                      color: Colors.black54,
                    )),
              ),
            ),
          ])),
    );
  }
}
