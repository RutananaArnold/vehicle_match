import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final vehicleOwnerChatController = Get.put(VehicleOwnerChatController());

class VehicleOwnerChatController extends GetxController {
  Stream<QuerySnapshot> getFirestoreData() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }
}
