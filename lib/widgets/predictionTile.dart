import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/dataModel/address.dart';
import 'package:uber_clone/dataModel/prediction.dart';
import 'package:uber_clone/dataProvider/appData.dart';
import 'package:uber_clone/helpers/requestHelper.dart';
import 'package:uber_clone/widgets/progressDialog.dart';

import '../brand_colors.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  PredictionTile(this.prediction);

  void getPlaceDetails(String placeID, context) async{

    showDialog(context: context, barrierDismissible: false ,builder: (BuildContext context) => ProgressDialog(status:'Please wait...' ,));

    String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=AIzaSyA18MNzjk_fM6KMyRnx4JAeloi1skVdkts';
    var response = await RequestHelper.getRequest(url);
    Navigator.pop(context);
    if(response == 'failed'){
      return ;
    }
    if(response['status'] == 'OK'){
      Address thisPlace = Address();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeID;

      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];
      Provider.of<AppData>(context, listen: false).updateDestinationAddress(thisPlace);
      Navigator.pop(context, 'getDirection');

    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
          getPlaceDetails(prediction.placeId, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: BrandColors.colorDimText,),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(prediction.manText,overflow: TextOverflow.ellipsis, maxLines: 1,style: TextStyle(fontSize: 16),),
                      SizedBox(height: 2,),
                      Text(prediction.secondaryText, overflow: TextOverflow.ellipsis, maxLines: 1,style: TextStyle(fontSize: 12, color: BrandColors.colorDimText),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}