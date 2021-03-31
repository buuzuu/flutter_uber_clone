import 'package:flutter/material.dart';

import '../brand_colors.dart';

class TaxiButton extends StatelessWidget {

  final String title;
  final Color color;
  final Function onPressed;


  TaxiButton(this.title, this.color, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: color,
      textColor: Colors.white,
      child: Container(
        height: 20,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontFamily: "Brand-Bold"),
          ),
        ),
      ),
    );
  }
}