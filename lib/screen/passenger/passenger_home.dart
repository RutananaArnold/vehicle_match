import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_match/controllers/passenger_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehicle_match/widgets/list_button.dart';
import 'package:vehicle_match/select_user.dart';

class PassengerHome extends StatefulWidget {
  const PassengerHome({Key? key}) : super(key: key);

  @override
  State<PassengerHome> createState() => _PassengerHomeState();
}

class _PassengerHomeState extends State<PassengerHome> {
  FirebaseAuth signedin = FirebaseAuth.instance;
  FirebaseAuth signout = FirebaseAuth.instance;

  signingout() async {
    await signout.signOut();
  }

  @override
  Widget build(BuildContext context) {
    passengerContrl.fetchVehicleContent();
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
      body: Center(
        child: GetBuilder<PassengerController>(
            init: PassengerController(),
            builder: (passengerSearch) {
              return Column(
                children: <Widget>[
                  Container(
                      color: Theme.of(context).primaryColor,
                      child: passengerSearch.buildSearchBox()),
                  Expanded(
                      child: passengerSearch.searchResult.isNotEmpty ||
                              passengerSearch.controller.text.isNotEmpty
                          ? passengerSearch.buildSearchResults()
                          : passengerSearch.buildSearchList()),
                ],
              );
            }),
      ),
    );
  }
}
