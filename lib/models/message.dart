import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final Timestamp sent;
  final int status;
  final String body;
  final String from;

  Message({this.sent, this.body, this.status, this.from});
}

List<Message> messages = [
  Message(
    body: "Hello",
    from: "Adrian",
    sent: Timestamp(1627489092, 0),
    status: 0,
  ),
  Message(
    body: "Yeah hi to you too",
    from: "Miriam",
    sent: Timestamp(1627489092, 0),
    status: 0,
  ),
];
