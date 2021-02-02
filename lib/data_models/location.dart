import 'dart:convert';
import 'package:flutter/material.dart';




class Location {
  final double latitude;
  final double longitude;
  final String country;
  final String state;
  final String city;


  /// [Dart Data Class]
  Location({
    @required this.latitude,
    @required this.longitude,
    @required this.country,
    @required this.state,
    @required this.city,
  });



  Location copyWith({
    double latitude,
    double longitude,
    String country,
    String state,
    String city,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'state': state,
      'city': city,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Location(
      latitude: map['latitude'],
      longitude: map['longitude'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location(latitude: $latitude, longitude: $longitude, country: $country, state: $state, city: $city)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Location &&
      o.latitude == latitude &&
      o.longitude == longitude &&
      o.country == country &&
      o.state == state &&
      o.city == city;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
      longitude.hashCode ^
      country.hashCode ^
      state.hashCode ^
      city.hashCode;
  }
}
