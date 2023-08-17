// ignore_for_file: unnecessary_null_comparison



import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   LocationData? userLocation;
  late bool serviceEnabled;
  final MapController mapController = MapController();

  @override
  void initState() {
    initialLocation();
    super.initState();
  }

  Future<void> initialLocation() async {
    Location location =  Location();
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }


    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    userLocation = await location.getLocation();
    mapController.move(LatLng(userLocation!.latitude!, userLocation!.longitude!), 16);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.move(LatLng(userLocation!.latitude!, userLocation!.longitude!), 16);
        },
        child: const Icon(Icons.location_searching),
      ),
      body : FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: const LatLng(35.715298, 51.404343),
          zoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            backgroundColor: Colors.brown.shade300,
          ),
          MarkerLayer(
            markers: [
              if(userLocation != null)...[
                Marker(
                    point: LatLng(userLocation!.latitude!,userLocation!.longitude!),
                    builder: (context) => const Icon(Icons.location_on,color: Colors.redAccent),)
              ]
            ],
          )
        ],
      )
    );
  }
}
