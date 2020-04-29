import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Test extends StatefulWidget
{
  @override
  _TestState createState() => _TestState();

}

  
  class _TestState extends State<Test> {
    String name,email,displayPicture,auth,googleSign;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = new GoogleSignIn();


void getUID() async{
  FirebaseUser user = await _auth.currentUser();
  Firestore.instance.collection("users").add({
    'userID' : user.uid
  });
}

  
   signInWithGoogle() async{
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    
    var authResult = await _auth.signInWithCredential(credential);      
    return authResult.user;
  }


  signInSilently() async {
    
    var user = await googleSignIn.signInSilently();
    var name = user.displayName;
    var email = user.email;
    

    
   var displayPicture = user.photoUrl; 
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen(
          name: name,
          email: email,
          displaypicURL: displayPicture,
           auth: _auth,
           googleSignIn: googleSignIn,     
          
        )
      )
    );
  }

  
  Widget signInButton(){
    return new Container(
  width: 250,
  height: 40.0,

      child: new RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
        ),


        onPressed: () async {
          getUID();
          var user = await signInWithGoogle();
          var name = user.displayName;
          var email = user.email;
          var displayPicture = user.photoUrl;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context)=> HomeScreen(
                name: name,
                email: email,
                displaypicURL: displayPicture,
                googleSignIn: googleSignIn,
                auth: _auth,

              )
            )
          );
        },
      child: Row(
        children: <Widget>[
          Icon(FontAwesomeIcons.google, color: Color(0xffCE107C),),
          SizedBox(width: 21.0,),
          
          Text('Sign in with Google',style: TextStyle(color: Colors.black,fontSize: 15.0)
        
          )
        ]
      ),
      ),
    );
  }
@override
void initState()
{
  signInSilently();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       body: Center(
        
        
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                 
        
          height: MediaQuery.of(context).size.height/1.2,
          width: MediaQuery.of(context).size.width/1.5,
          child: FlareActor(
            "assets/searching.flr",
            animation: "walking",
            fit: BoxFit.cover,
          ),

              ),
             signInButton()
            ],
         
        ),
      ),
       )
    );

    
    
  }
}