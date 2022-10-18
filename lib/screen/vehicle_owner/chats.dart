import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_match/controllers/vehicle_owner_chats_controller.dart';
import 'package:vehicle_match/models/chat_user.dart';

class VehicleOwnerChats extends StatefulWidget {
  const VehicleOwnerChats({Key? key}) : super(key: key);

  @override
  State<VehicleOwnerChats> createState() => _VehicleOwnerChatsState();
}

class _VehicleOwnerChatsState extends State<VehicleOwnerChats> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: vehicleOwnerChatController.getFirestoreData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if ((snapshot.data?.docs.length ?? 0) > 0) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(snapshot.data!.docs.first.id),
                          ),
                          // buildItem(context, snapshot.data?.docs[index]),
                          controller: scrollController,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        );
                      } else {
                        return const Center(
                          child: Text('No user found...'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
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
