import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Voucher extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        title: Text('Vouchers',
       style: TextStyle(
         
       ),
       textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Container(
          height: 300,
          width:300,
          child: FlareActor(
            "assets/Giftbox.flr",
            animation:"gift_box_animation",
            fit: BoxFit.cover,
          ),
        ),
      ),

    );
  }
  
}