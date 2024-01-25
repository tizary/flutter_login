import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/header.dart';
import 'package:flutter_application_1/utils/network_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_maps_webservices/places.dart';

const currentLocation = LatLng(45.433407932785656, 12.33051294893916);
const apiKey = 'AIzaSyDWZWwMKwJDS6Fd1cBXIzis1xfOgpreOmg';

class AddressPageWidget extends StatefulWidget {
  const AddressPageWidget({super.key});

  @override
  State<AddressPageWidget> createState() => _AddressPageWidgetState();
}

class _AddressPageWidgetState extends State<AddressPageWidget> {
  final _searchController = TextEditingController();
  GoogleMapController? _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void moveToLocation(LatLng location) {
    _mapController!.animateCamera(CameraUpdate.newLatLng(location));
  }

  Future<void> findLocation(String placeName) async {
    if (placeName.isEmpty) return;

    final places = GoogleMapsPlaces(apiKey: apiKey);
    var response = await places.searchByText("London");
    if (response.results.isNotEmpty) {
      var result = response.results.first;
      moveToLocation(
          LatLng(result.geometry!.location.lat, result.geometry!.location.lng));
    }
  }

  checkInternet() async {
    return await NetworkUtil.hasConnection();
  }

  @override
  Widget build(BuildContext context) {
    return (checkInternet() == false)
        ? Scaffold(
            appBar: const Header(pageTitle: 'Address'),
            body: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _searchController,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                          ),
                          onChanged: (value) => findLocation(value),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          findLocation(_searchController.text);
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
                Expanded(
                  child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: const CameraPosition(
                          target: currentLocation, zoom: 12.0)),
                ),
              ],
            ),
          )
        : const Scaffold(
            appBar: Header(pageTitle: 'Address'),
            body: Center(child: Text('Map cannot be loaded without internet')),
          );
  }
}
