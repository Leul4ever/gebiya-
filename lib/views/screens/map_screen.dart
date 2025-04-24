import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:ecommerce/screens/home_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Default position (will be updated with current location)
  LatLng currentPosition = LatLng(37.42796133580664, -122.085749655962);
  final MapController mapController = MapController();
  bool locationObtained = false;
  double currentZoom = 14.0;

  @override
  void initState() {
    super.initState();
    getUserCurrentLocation();
  }

  getUserCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      locationObtained = true;
    });

    // Move camera to current position when location is obtained
    mapController.move(currentPosition, 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentPosition,
              initialZoom: 14.0,
              onMapReady: () {
                if (locationObtained) {
                  mapController.move(currentPosition, 15.0);
                }
              },
              onPositionChanged: (position, hasGesture) {
                setState(() {
                  currentZoom = position.zoom ?? currentZoom;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.leul.ecommerce',
              ),
              MarkerLayer(
                markers: [
                  if (locationObtained)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: currentPosition,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Camera control buttons
          Positioned(
            right: 16,
            top: 50,
            child: Column(
              children: [
                // Zoom in button
                FloatingActionButton(
                  mini: true,
                  heroTag: "zoomIn",
                  onPressed: () {
                    final currentCenter = mapController.camera.center;
                    mapController.move(currentCenter, currentZoom + 1);
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                // Zoom out button
                FloatingActionButton(
                  mini: true,
                  heroTag: "zoomOut",
                  onPressed: () {
                    final currentCenter = mapController.camera.center;
                    mapController.move(currentCenter, currentZoom - 1);
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(height: 8),
                // Current location button
                FloatingActionButton(
                  mini: true,
                  heroTag: "myLocation",
                  onPressed: () {
                    if (locationObtained) {
                      mapController.move(currentPosition, 15.0);
                    } else {
                      getUserCurrentLocation();
                    }
                  },
                  child: const Icon(Icons.my_location),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 70,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.offAll(MainScreen());
                      },
                      icon: const Icon(CupertinoIcons.shopping_cart),
                      label: const Text(
                        'SHOP NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
