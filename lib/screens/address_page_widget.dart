import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/header.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const currentLocation = LatLng(45.433407932785656, 12.33051294893916);

class AddressPageWidget extends StatefulWidget {
  const AddressPageWidget({super.key});

  @override
  State<AddressPageWidget> createState() => _AddressPageWidgetState();
}

class _AddressPageWidgetState extends State<AddressPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(pageTitle: 'Address'),
      body: const GoogleMap(
          initialCameraPosition:
              CameraPosition(target: currentLocation, zoom: 12.0)),
    );
  }
}
