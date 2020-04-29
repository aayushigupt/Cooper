import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing/screens/googleMap.dart';
import 'package:testing/screens/loginPage.dart';
import 'package:testing/screens/registration.dart';
import 'package:testing/screens/vouchers.dart';

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
      height: 40,
      width: 110,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: () async {
          await widget.auth.signOut();
          await  widget.googleSignIn.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context)=> Test()
          ));
          print('signout');
        },
        child: Text('Sign Out'),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Home'),
      ),
drawer: Drawer(
  
  child: ListView(
  
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
      
    ),
    Divider(
      height: 80.0,
    ),
    ListTile(
      
      title: new Text('Map Ploting'),
      leading: Icon(Icons.map),
      onTap: ()=> Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext)=> GoogleMaps(),
      ))
         ),
         Divider(
           height: 10.0,
         ),
    new ListTile(
      title: Text('Remarks'),
      leading: Icon(Icons.note),
      onTap: ()=> Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext)=> Register(),
      )),
    ),
    Divider(
      height: 10.0,
    ),
    new ListTile(
      title: Text('Vouchers'),
      leading: Icon(Icons.card_giftcard),
      onTap: ()=> Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext)=> Voucher(),
      )
      )
    ),
    SizedBox(
      height: 40.0,
    ),
    Container(
    alignment: Alignment.bottomCenter,
      child: signOutButton()),
    
  ],
    
),

),
body: SingleChildScrollView(
  child: Center(
    child: Container(
      padding: EdgeInsets.only(top: 300.0),

      child: Text('Environmental cleanliness begins with each individual desire to be clean',
      style: TextStyle(
        fontSize: 10.0,
      ),
      ),
    ),
  ),
),
       floatingActionButton: FloatingActionButton(
         onPressed:(){
           Navigator.pushReplacement(context, MaterialPageRoute(
             builder: (BuildContext context) => GoogleMaps()
           ));
         },
         child: Icon(Icons.map),
       ),
    );

     
    
  }
  
 
}