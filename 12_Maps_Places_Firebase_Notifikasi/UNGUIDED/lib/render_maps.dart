import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RenderMaps extends StatefulWidget {
  const RenderMaps({super.key});

  @override
  State<RenderMaps> createState() => _RenderMapsState();
}

class _RenderMapsState extends State<RenderMaps> {
  static final LatLng _defaultLocation = LatLng(-6.200000, 106.816666);

  static final CameraPosition _cameraPosition = CameraPosition(
    target: _defaultLocation,
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
