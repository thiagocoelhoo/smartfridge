import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearbySupermarketsPage extends StatefulWidget {
  @override
  _NearbySupermarketsPageState createState() => _NearbySupermarketsPageState();
}

class _NearbySupermarketsPageState extends State<NearbySupermarketsPage> {
  Position? _currentPosition;
  String _currentAddress = 'Buscando localização...';
  final List<Marker> _markers = [];
  final String _apiUrl = 'http://10.0.0.104:8000/supermarkets';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Serviço de localização está desativado.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissão de localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão de localização negada permanentemente.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _currentAddress =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      _addMarker(position);
      _getNearbySupermarkets();
    });
  }

  void _addMarker(Position position) {
    _markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(position.latitude, position.longitude),
        builder: (ctx) => Container(
          child: Icon(Icons.location_pin, color: Colors.red, size: 40),
        ),
      ),
    );
  }

  Future<void> _getNearbySupermarkets() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      for (var supermarket in data) {
        final double lat = supermarket['latitude'];
        final double lng = supermarket['longitude'];
        final String name = supermarket['name'];

        setState(() {
          _markers.add(
            Marker(
              width: 80.0,
              height: 120.0,
              point: LatLng(lat, lng),
              builder: (ctx) => Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Icon(Icons.shopping_cart,
                          color: Colors.blue, size: 30),
                      const SizedBox(height: 8.0),
                      Text(name,
                          style: const TextStyle(color: Colors.blueAccent)),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      }
    } else {
      throw Exception('Failed to load nearby supermarkets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("Supermercados Próximos"),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
    );
  }
}