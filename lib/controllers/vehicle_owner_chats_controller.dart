import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vehicle_match/models/user_chat.dart';

final vehicleOwnerChatController = Get.put(VehicleOwnerChatController());

class VehicleOwnerChatController extends GetxController {
  List<UserChat> chatsNow = [];

  getFirestoreChats() async {
    await FirebaseFirestore.instance
        .collection("chats")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chatsNow.add(
          UserChat(
            content: doc["content"],
            idFrom: doc["idFrom"],
            idTo: doc["idTo"],
            timeStamp: doc["timeStamp"],
          ),
        );
        update();
        // print("add data to list");
        // print(chatsNow[0].content);
        // print(chatsNow[0].idTo);
        // print(FirebaseAuth.instance.currentUser!.uid);
      }
    });
  }
}
