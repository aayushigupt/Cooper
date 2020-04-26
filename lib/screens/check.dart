import 'package:flutter/material.dart';
import 'package:testing/screens/home.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/animation.dart';
class Check extends StatefulWidget{
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check>  with SingleTickerProviderStateMixin{
   Animation animation;

  AnimationController animationController;

  @override
  void initState()
  {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 6), vsync: this);
    animationController.forward();
    animationController.addStatusListener((listener){
if(listener == AnimationStatus.completed){
  Navigator.pop(context, MaterialPageRoute(
builder: (BuildContext context)=> HomeScreen(),
  ));
}
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
          body: Center(
        
        
        child: Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.bottomCenter,
         height:500,
         width:500,
        
         
          child: FlareActor(
            
            "assets/Checkbox.flr",
            animation: "checkmark_appear",
            
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}