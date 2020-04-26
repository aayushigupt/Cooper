import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/animation.dart';
import 'package:testing/screens/loginPage.dart';

class Start extends StatefulWidget
{
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> with SingleTickerProviderStateMixin{
  Animation animation;

  AnimationController animationController;

  @override
  void initState()
  {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 9), vsync: this);
    animationController.forward();
    animationController.addStatusListener((listener){
if(listener == AnimationStatus.completed){
  Navigator.push(context, MaterialPageRoute(
builder: (BuildContext context)=> Test()
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
          padding: EdgeInsets.only(bottom: 150.0),
        
          height: MediaQuery.of(context).size.height/1.2,
          width: MediaQuery.of(context).size.width/1.5,
          child: FlareActor(
            "assets/work.flr",
            animation: "animation",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

 
}