import 'package:flutter/material.dart';
//import './screens/loginPage.dart';
import './screens/StartScreen.dart';
void main()
{
  runApp(Application());
}

class Application extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Start(),
    );
  }
  
}