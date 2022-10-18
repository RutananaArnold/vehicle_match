import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PassengerChatPage extends StatefulWidget {
  final String vehicleUserId;
  const PassengerChatPage({
    Key? key,
    required this.vehicleUserId,
  }) : super(key: key);

  @override
  State<PassengerChatPage> createState() => _PassengerChatPageState();
}

class _PassengerChatPageState extends State<PassengerChatPage> {
  // Create a CollectionReference called vehicleRequests that references the firestore collection
  CollectionReference requests = FirebaseFirestore.instance.collection('chats');
  final List<types.Message> messages = [];
  final user = types.User(id: FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FirebaseAuth.instance.currentUser!
            .linkWithCredential(AuthCredential(
                providerId: widget.vehicleUserId,
                signInMethod: "Email/Password"))
            .toString()),
      ),
      body: Chat(
          messages: messages, onSendPressed: handleSendPressed, user: user),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: FirebaseAuth.instance.currentUser!.uid,
      text: message.text,
    );
    _addMessage(textMessage);
    sendMessage(FirebaseAuth.instance.currentUser!.uid, widget.vehicleUserId,
        DateTime.now().millisecondsSinceEpoch.toString(), message.text);
  }

// uploading mesage to firestore
  Future<void> sendMessage(
      String idFrom, String idTo, String timeStamp, String content) {
    return requests
        .add({
          'idFrom': idFrom,
          'idTo': idTo,
          'timeStamp': timeStamp,
          'content': content,
        })
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Message Sent"))))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to send message: $error"))));
  }
}
