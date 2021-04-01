import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/dataModel/address.dart';
import 'package:uber_clone/dataModel/directionDetails.dart';
import 'package:uber_clone/dataModel/user.dart';
import 'package:uber_clone/dataProvider/appData.dart';
import 'package:uber_clone/globalVariables.dart';
import 'package:uber_clone/helpers/requestHelper.dart';

class HelperMethods {
  static Future<String> findCordinateAddress(
      Position position, BuildContext context) async {
    String placeAddress = '';

    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyA18MNzjk_fM6KMyRnx4JAeloi1skVdkts";

    var response = await RequestHelper.getRequest(url);
    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];
      Address pickupAddress = new Address();
      pickupAddress.longitude = position.longitude;
      pickupAddress.latitude = position.latitude;
      pickupAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickupAddress(pickupAddress);
    }

    return placeAddress;
  }

  static Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyA18MNzjk_fM6KMyRnx4JAeloi1skVdkts";
    var response = await RequestHelper.getRequest(url);
    if (response == 'failed') {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];
    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];
    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }

  static int estimateFare(DirectionDetails details) {
    // per km = $0.3
    // per minute = $0.2
    // base fare = $3
    double baseFare = 3;
    double distanceFare = (details.distanceValue / 1000) * 0.3;
    double timeFare = (details.durationValue / 60) * 0.2;
    double totalFare = baseFare + distanceFare + timeFare;
    return totalFare.truncate();
  }

  static void getCurrentUserInfo() async {
     GlobalVariables.currentFirebaseUser = await FirebaseAuth.instance.currentUser();
    String userID = GlobalVariables.currentFirebaseUser.uid;


    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$userID');

    userRef
        .once()
        .then((DataSnapshot snapshot) {
          if (snapshot.value != null)
          {
          GlobalVariables.currentUserInfo = User.fromSnapshot(snapshot);
          print('My name is ${GlobalVariables.currentUserInfo .fullName}');
          }
        });
  }
}
