import 'dart:async';
import 'package:geocoding/geocoding.dart' as geoCoding;   /// [重複: data_models/location.dart <-> geocoding郡/location.dart]
import 'package:geolocator/geolocator.dart';
import 'package:min3_minstag_ram/data_models/location.dart';




class LocationManager {



  Future<Location> getCurrentLocation() async {
    /// [grab permission error part |>]
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permantly denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return Future.error('Location permissions are denied (actual value: $permission).');
      }
    }
    /// [>|]
    /// [Use data part]
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);  /// [low低精度->longTime->longCircular]
    final placeMarks = await geoCoding.placemarkFromCoordinates(position.latitude, position.longitude,);
    final placeMark = placeMarks.first;
    /// [geoCodingのplaceMarkクラスをLocationにconvertして返す]
    return Future.value(  convert(placeMark, position.latitude, position.longitude)  );
  }



  Location convert(geoCoding.Placemark placeMark, double latitude, double longitude) {
    return Location(
      latitude: latitude,
      longitude: longitude,
      country: placeMark.country,
      state: placeMark.administrativeArea,
      city: placeMark.locality,
    );
  }



  Future<Location> updateLocation(double latitude, double longitude) async {
    final placeMarks = await geoCoding.placemarkFromCoordinates(latitude,longitude,);
    final placeMark = placeMarks.first;
    return Future.value(  convert(placeMark, latitude, longitude)  );
  }


}