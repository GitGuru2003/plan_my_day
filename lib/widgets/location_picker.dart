import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  const LocationPicker({super.key, required this.onLocationSelected});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late GoogleMapController _mapController;
  LatLng _selectedLocation = const LatLng(37.7749, -122.4194);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _selectedLocation = LatLng(position.latitude, position.longitude);
        });
        widget.onLocationSelected(_selectedLocation);
      } catch (e) {
        debugPrint('Error getting location: $e');
      }
    } else {
      debugPrint('Location permission denied');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.moveCamera(CameraUpdate.newLatLng(_selectedLocation));
  }

  void _onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
    widget.onLocationSelected(location);
  }

  void _centerOnLocation() {
    _getCurrentLocation();
    _mapController.animateCamera(CameraUpdate.newLatLng(_selectedLocation));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 300,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  onTap: _onTap,
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('selected-location'),
                      position: _selectedLocation,
                    ),
                  },
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
                    ..add(Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer()))
                    ..add(Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer())),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Selected Location: ${_selectedLocation.latitude.toStringAsFixed(4)}, ${_selectedLocation.longitude.toStringAsFixed(4)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        Positioned(
          top: 16,
          right: 16,
          child: SizedBox(
            height: 40,
            width: 40,
            child: FloatingActionButton(
              onPressed: _centerOnLocation,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.my_location, size: 22, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
