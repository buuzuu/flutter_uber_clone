import 'package:flutter/material.dart';
import 'package:uber_clone/dataModel/address.dart';

class AppData extends ChangeNotifier {

  Address pickupAddress;

  Address destinationAddress;
  void updateDestinationAddress(Address ad){
    destinationAddress = ad ;
    notifyListeners();
  }

  void updatePickupAddress(Address pickup){
    pickupAddress = pickup;
    notifyListeners();
  }






}