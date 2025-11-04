import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/widgets/app_bar_with_back_button.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class AddNewAddress extends StatefulWidget {
  AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  LatLng _coords = LatLng(51.509364, -0.128928);
  MapController _mapController = MapController();
  double _defaultZoom = 9.2;

  @override
  void initState() {
    super.initState();
    determinePosition().then((Position position) {
      final newCoords = LatLng(position.latitude, position.longitude);
      clog.info('New coords: $newCoords');
      setState(() {
        _coords = newCoords;
        _mapController.move(newCoords, _defaultZoom);
      });
    }).catchError((e) {
      clog.error(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackButton(title: 'Add New Address', centerTitle: true),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _coords,
          initialZoom: _defaultZoom,
        ),
        mapController: _mapController,
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          DragMarkers(
            markers: [
              DragMarker(
                size: Size(50, 50),
                point: _coords,
                offset: const Offset(0.0, -8.0),
                builder: (_, __, isDragging) {
                  return const Icon(
                    Icons.location_on,
                    size: 50,
                    color: ColorPlanet.primary,
                  );
                },
                onDragEnd: (DragEndDetails details, LatLng latLng) {
                  setState(() {
                    _coords = latLng;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
