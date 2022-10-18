import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleOwnerChats extends StatefulWidget {
  const VehicleOwnerChats({Key? key}) : super(key: key);

  @override
  State<VehicleOwnerChats> createState() => _VehicleOwnerChatsState();
}

class _VehicleOwnerChatsState extends State<VehicleOwnerChats> {
  @override
  void initState() {
    super.initState();
    // vehicleOwnerChatController.getFirestoreChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Recent Chats"),
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body: Column(
          children: [Text("No chats found")],
        ));
  }

  //  Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot) {
  //   final firebaseAuth = FirebaseAuth.instance;
  //   if (documentSnapshot != null) {
  //     // ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
  //     if (userChat.uid == firebaseAuth.currentUser!.uid) {
  //       return const SizedBox.shrink();
  //     } else {
  //       return TextButton(
  //         onPressed: () {
  //           if (KeyboardUtils.isKeyboardShowing()) {
  //             KeyboardUtils.closeKeyboard(context);
  //           }
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => ChatPage(
  //                         peerId: userChat.uid,
  //                         peerAvatar: userChat.email,
  //                         peerNickname: userChat.displayName,
  //                         userAvatar: firebaseAuth.currentUser!.photoURL!,
  //                       )));
  //         },
  //         child: ListTile(
  //           leading: userChat.email.isNotEmpty
  //               ? ClipRRect(
  //                   borderRadius: BorderRadius.circular(Sizes.dimen_30),
  //                   child: Image.network(
  //                     userChat.email,
  //                     fit: BoxFit.cover,
  //                     width: 50,
  //                     height: 50,
  //                     loadingBuilder: (BuildContext ctx, Widget child,
  //                         ImageChunkEvent? loadingProgress) {
  //                       if (loadingProgress == null) {
  //                         return child;
  //                       } else {
  //                         return SizedBox(
  //                           width: 50,
  //                           height: 50,
  //                           child: CircularProgressIndicator(
  //                               color: Colors.grey,
  //                               value: loadingProgress.expectedTotalBytes !=
  //                                       null
  //                                   ? loadingProgress.cumulativeBytesLoaded /
  //                                       loadingProgress.expectedTotalBytes!
  //                                   : null),
  //                         );
  //                       }
  //                     },
  //                     errorBuilder: (context, object, stackTrace) {
  //                       return const Icon(Icons.account_circle, size: 50);
  //                     },
  //                   ),
  //                 )
  //               : const Icon(
  //                   Icons.account_circle,
  //                   size: 50,
  //                 ),
  //           title: Text(
  //             userChat.displayName,
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //         ),
  //       );
  //     }
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }
}
