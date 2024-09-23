import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NearbySupermarketsPage extends StatefulWidget {
  @override
  _NearbySupermarketsPageState createState() => _NearbySupermarketsPageState();
}

class _NearbySupermarketsPageState extends State<NearbySupermarketsPage> {
  Position? _currentPosition;
  String _currentAddress = 'Buscando localização...';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: const Text("Supermercados Próximos"),
      ),
      body: Center(
        child: _currentPosition == null
            ? CircularProgressIndicator()
            : Text(_currentAddress),
      ),
    );
  }
}
