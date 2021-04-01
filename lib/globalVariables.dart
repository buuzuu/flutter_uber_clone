import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dataModel/user.dart';


class GlobalVariables {
  String mapKey = "AIzaSyA18MNzjk_fM6KMyRnx4JAeloi1skVdkts";
  static FirebaseUser currentFirebaseUser ;
  static User currentUserInfo ;
  static final CameraPosition initialPosition = CameraPosition(
    target: LatLng(53.348194, -6.265181),
    zoom: 14.4746,
  );
}





// https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyA18MNzjk_fM6KMyRnx4JAeloi1skVdkts

// Places DoNothingAndStopPropagationIntent
// https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1600+Amphitheatre&key=AIzaSyA18MNzjk_fM6KMyRnx4JAeloi1skVdkts&sessiontoken=1234567890
// https://maps.googleapis.com/maps/api/directions/json?origin={latitude},{longitude}&destination={latitude},{longitude}&mode=driving&key=AIzaSyA18MNzjk_fM6KMyRnx4JAeloi1skVdkts