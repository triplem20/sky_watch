
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class Location {
  late double longitude;
  late double latitude;


    Future<void> getCurrentPosition() async {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude;
        longitude = position.longitude;
      } catch (e) {
        print(e);
      }
    }
  }


