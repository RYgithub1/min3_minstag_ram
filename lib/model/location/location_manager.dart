import 'dart:async';

import 'package:geocoding/geocoding.dart' as geoCoding;   /// [重複: data_models/location.dart <-> geocoding郡/location.dart]
import 'package:geolocator/geolocator.dart';
import 'package:min3_minstag_ram/data_models/location.dart';




class LocationManager {



  Future<Location> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    final placeMarks = await geoCoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final placeMark = placeMarks.first;
    /// [geoCodingのplaceMarkクラスをLocationにconvertして返す]
    return Future.value(  convert(placeMark, position.latitude, position.longitude)  );

  }

  Location convert(geoCoding.Placemark placeMark, double latitude, double longitude) {
    return Location(
      latitude: latitude,
      longitude: longitude,
      country: placeMark.country,

    );
  }



}