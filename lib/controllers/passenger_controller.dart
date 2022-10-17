import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:vehicle_match/models/vehicle_content.dart';

final passengerContrl = Get.put(PassengerController());

class PassengerController extends GetxController {
  List<VehicleContents> vehiclesNow = [];

  fetchVehicleContent() async {
    await FirebaseFirestore.instance
        .collection("vehicleRequests")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        vehiclesNow.add(
          VehicleContents(
              dateOfDeparture: doc["dateOfDeparture"],
              destLocation: doc["destLocation"],
              pickupLocation: doc["pickupLocation"],
              seatsNumber: doc["seatsNumber"],
              timeOfDeparture: doc["timeOfDeparture"],
              vehicleUserId: doc["vehicleUserId"]),
        );
      }
    });
    update();
  }
}
