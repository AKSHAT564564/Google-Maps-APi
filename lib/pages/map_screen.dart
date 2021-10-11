import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GmapScreen extends StatefulWidget {
  const GmapScreen({Key? key}) : super(key: key);

  @override
  _GmapScreenState createState() => _GmapScreenState();
}

class _GmapScreenState extends State<GmapScreen> {
  Completer<GoogleMapController> _controller = Completer();
   final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );
 Set<Marker> _markers = {};
  Location _location = Location();



  @override
  void initState() {
    super.initState();
    // _markers[MarkerId("val")]=  Marker(markerId: const MarkerId("1"),position: _kGooglePlex.target);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gmap '),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _currentLocation,
        label: const Text('Get Location'),
        icon: const Icon(Icons.location_pin),
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;

    late LocationData currentLocation;
    var location = Location();

    try {
      currentLocation = await location.getLocation();
    } on Exception {
      print("Not Worked");
    }
     
     
     controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 17.0,
      ),
    ));
//     final Marker marker = Marker(
//   markerId: MarkerId(makerIdValue),
//   position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
// );
//     setState(() {
//       _markers[markerId] = marker;
//     });
  }
}
