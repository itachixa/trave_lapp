import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(48.8566, 2.3522); // Paris coordinates

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('paris'),
      position: LatLng(48.8566, 2.3522),
      infoWindow: InfoWindow(
        title: 'Paris',
        snippet: 'City of Light',
      ),
    ),
    const Marker(
      markerId: MarkerId('tokyo'),
      position: LatLng(35.6762, 139.6503),
      infoWindow: InfoWindow(
        title: 'Tokyo',
        snippet: 'Modern meets traditional',
      ),
    ),
    const Marker(
      markerId: MarkerId('newyork'),
      position: LatLng(40.7128, -74.0060),
      infoWindow: InfoWindow(
        title: 'New York',
        snippet: 'The Big Apple',
      ),
    ),
    const Marker(
      markerId: MarkerId('bali'),
      position: LatLng(-8.3405, 115.0920),
      infoWindow: InfoWindow(
        title: 'Bali',
        snippet: 'Tropical paradise',
      ),
    ),
    const Marker(
      markerId: MarkerId('rome'),
      position: LatLng(41.9028, 12.4964),
      infoWindow: InfoWindow(
        title: 'Rome',
        snippet: 'Eternal City',
      ),
    ),
    const Marker(
      markerId: MarkerId('dubai'),
      position: LatLng(25.2048, 55.2708),
      infoWindow: InfoWindow(
        title: 'Dubai',
        snippet: 'City of Gold',
      ),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Map'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              // Get current location (not implemented yet)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Location feature coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 3.0,
            ),
            markers: _markers,
            mapType: MapType.normal,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Popular Destinations',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap on markers to explore destinations around the world',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(_center, 5.0),
                            );
                          },
                          icon: const Icon(Icons.zoom_in),
                          label: const Text('Zoom In'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(_center, 2.0),
                            );
                          },
                          icon: const Icon(Icons.zoom_out),
                          label: const Text('Zoom Out'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}