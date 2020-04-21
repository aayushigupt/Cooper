import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing/screens/loginPage.dart';

class HomeScreen extends StatefulWidget{
  final String name,email,displaypicURL;
  final GoogleSignIn googleSignIn;
  final FirebaseAuth auth;

  
  HomeScreen({this.name, this.email, this.displaypicURL, this.googleSignIn, this.auth });

  
  @override
  _HomeScreenState createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {

  Widget signOutButton(){
    return Container(
      child: RaisedButton(
        onPressed: () async {
          await widget.auth.signOut();
          await  widget.googleSignIn.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext)=> Test()
          ));
          print('signout');
        },
        child: Text('Sign Out'),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
drawer: Drawer(child: ListView(
  children: <Widget>[
    
    UserAccountsDrawerHeader(
      accountName: Text(
        widget.name,
      ),
      accountEmail: Text(
        widget.email,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
          widget.displaypicURL,
        ),
      )
      
    )
  ],
),),
body: SingleChildScrollView(
  child: Center(
    child: Column(
      children: <Widget>[
        signOutButton(),
      ],
    ),
  ),
),
       
    );

     
    
  }
  
 
}