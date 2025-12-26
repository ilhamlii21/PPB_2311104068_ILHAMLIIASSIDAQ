import 'package:place_picker_google/place_picker_google.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacePickerScreen extends StatefulWidget {
  const PlacePickerScreen({super.key});

  @override
  State<PlacePickerScreen> createState() => PlacePickerScreenState();
}

class PlacePickerScreenState extends State<PlacePickerScreen> {
  static final LatLng _initialPosition = LatLng(-6.200000, 106.816666);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Picker Example'),
      ),
      body: PlacePicker(
        apiKey: "AIzaSyAhLKzV0RnTmIyg1LM3Gbo62tucGfuZTn8",
        initialLocation: _initialPosition,   // <-- PARAMETER YANG BENAR
      ),
    );
  }
}
