// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:vehicle_match/screen/vehicle_owner/chats.dart';
import 'package:vehicle_match/screen/vehicle_owner/upload_vehicle.dart';
import 'package:vehicle_match/select_user.dart';
import 'package:vehicle_match/widgets/list_button.dart';

class VehicleOwnerHome extends StatefulWidget {
  const VehicleOwnerHome({Key? key}) : super(key: key);

  @override
  State<VehicleOwnerHome> createState() => _VehicleOwnerHomeState();
}

class _VehicleOwnerHomeState extends State<VehicleOwnerHome> {
  final Stream<QuerySnapshot> requestsStream =
      FirebaseFirestore.instance.collection('vehicleRequests').snapshots();
  FirebaseAuth signedin = FirebaseAuth.instance;
  FirebaseAuth signout = FirebaseAuth.instance;

  signingout() async {
    await signout.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        title: const Text("Recent Vehicle Specifications"),
        actions: [
          PopupMenuButton(
              offset: const Offset(0, 40),
              onCanceled: () {},
              elevation: 40,
              icon: const Icon(Icons.menu),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        "Signed in as: ${signedin.currentUser!.email}",
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: ListButton(
                        label: 'Sign Out',
                        icon: Icons.outbond_outlined,
                        onTap: () {
                          signingout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const WelcomeScreen())),
                              (route) => false);
                        },
                      ),
                    ),
                  ])
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: requestsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  tileColor: Colors.green[200],
                  title: RichText(
                      text: TextSpan(
                          text: "Pickup Location: ${data['pickupLocation']} \n",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(text: "Destination: ${data['destLocation']}")
                      ])),
                  subtitle: RichText(
                      text: TextSpan(
                          text: "Departure Time: ${data['timeOfDeparture']} \n",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: "Departure Date: ${data['dateOfDeparture']}")
                      ])),
                  trailing: Chip(
                      label: Text(
                    "Seats: ${data['seatsNumber']}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.car_rental_rounded),
              label: "Upload Vehicle Specifications",
              backgroundColor: Colors.red,
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: ((context) => const UploadVehicle())),
                    (route) => true);
              }),
          SpeedDialChild(
              child: const Icon(Icons.chat_sharp),
              label: "Chats",
              backgroundColor: Colors.green,
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: ((context) => const VehicleOwnerChats())),
                    (route) => true);
              }),
        ],
      ),
    );
  }
}
