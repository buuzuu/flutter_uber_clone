import 'package:flutter/material.dart';

class Prediction{
  String placeId;
  String manText;
  String secondaryText;

  Prediction({this.placeId, this.manText, this.secondaryText});


  Prediction.fromJson(Map<String, dynamic> json){
    placeId = json['place_id'];
    manText = json['structured_formatting']['main_text'];
    secondaryText = json['structured_formatting']['secondary_text'];

  }


}