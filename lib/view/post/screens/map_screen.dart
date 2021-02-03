import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:min3_minstag_ram/data_models/location.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class MapScreen extends StatefulWidget {

  final Location location;
  MapScreen({this.location});

  @override
  _MapScreenState createState() => _MapScreenState();
}




class _MapScreenState extends State<MapScreen> {

  LatLng _latLng;
  CameraPosition _cameraPosition;
  @override
  void initState() {
    super.initState();
    _latLng = LatLng(widget.location.latitude, widget.location.longitude);
    _cameraPosition = CameraPosition(target: _latLng, zoom: 15.0);
  }

  GoogleMapController _mapController;
  /*
  機能拡張用： GoogleMapController _mapController;
  「onMapCreated」は文字通り地図が使えるようになった（Callback method for when the map is
  ready to be used.）で呼ばれるコールバックメソッド。
  通常はGoogleMapControllerのインスタンスを設定し、
  イベント処理等でCameraPositionの操作（animateCameraやmoveCamera）をする際に、
  GoogleMapControllerのメソッドを使用。
  */
  /// [地図タップしてマーカーヒュ時するため: Gmap注意: Marker/MarkedXxx/MarkerId]
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectPlace),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () => _onPlaceSelected(),   /// [マーカー変更後のデータ取得して表示]
          ),
        ],
      ),

      /// [GoogleMap]
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: onMapCreated,
        onTap: onMapTapped,
        markers: Set<Marker>.of(_markers.values),
      ),
    );
  }



  void onMapCreated(GoogleMapController controller) {
    print("comm200: onMapCreated");
    _mapController = controller;
  }



  void onMapTapped(LatLng latLng) {   /// [タップ]
    _latLng = latLng;
    print("comm201: onMapTapped: $_latLng");
    _createMarker(_latLng);
  }
  void _createMarker(LatLng latLng) {   /// [マーカー作成]
    print("comm202: _createMarker");
    final markerId = MarkerId("selected");
    final marker = Marker(markerId: markerId, position: latLng);
    setState(() {
      _markers[markerId] = marker;
    });
  }



  _onPlaceSelected() async {
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    await postViewModel.updateLocation(_latLng.latitude, _latLng.longitude);   /// [マーカーは緯度経度持っているため]
    Navigator.pop(context);
  }


}
