import 'package:flutter/material.dart';
import 'package:vehicle_match/controllers/passenger_controller.dart';

class PassengerHome extends StatefulWidget {
  const PassengerHome({Key? key}) : super(key: key);

  @override
  State<PassengerHome> createState() => _PassengerHomeState();
}

class _PassengerHomeState extends State<PassengerHome> {
  @override
  Widget build(BuildContext context) {
    passengerContrl.fetchVehicleContent();
    passengerContrl.vehiclesNow.length;
    return Scaffold(
        body: ListView(
      children: [
        ElevatedButton(
            onPressed: () {
              passengerContrl.fetchVehicleContent();
              print(passengerContrl.vehiclesNow[0].destLocation);
              print(passengerContrl.vehiclesNow.length);
            },
            child: Text("get data"))
      ],
    ));
  }
}
