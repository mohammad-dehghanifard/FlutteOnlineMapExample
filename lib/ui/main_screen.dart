import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : FlutterMap(
        options: MapOptions(
          center: const LatLng(35.715298, 51.404343),
          zoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            backgroundColor: Colors.blue,
          )
        ],
      )
    );
  }
}
