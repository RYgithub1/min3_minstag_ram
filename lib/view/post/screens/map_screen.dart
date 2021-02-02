import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:min3_minstag_ram/data_models/location.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';




class MapScreen extends StatefulWidget {

  final Location location;
  MapScreen({this.location});

  @override
  _MapScreenState createState() => _MapScreenState();
}




class _MapScreenState extends State<MapScreen> {

  GoogleMapController _mapController;

  LatLng _latLng;
  CameraPosition _cameraPosition;
  @override
  void initState() {
    super.initState();
    _latLng = LatLng(widget.location.latitude, widget.location.longitude);
    _cameraPosition = CameraPosition(target: _latLng, zoom: 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectPlace),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: null,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: onMapCreated,
      ),
    );
  }



  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }


}
