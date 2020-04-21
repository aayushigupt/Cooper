import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Test extends StatefulWidget
{
  @override
  _TestState createState() => _TestState();

}

  
  class _TestState extends State<Test> {
    String name,email,displayPicture,auth,googleSign;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = new GoogleSignIn();
  
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
        builder: (BuildContext) => HomeScreen(
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
      child: new RaisedButton(
        onPressed: () async {
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
        child: Text('Sign in with Google'),
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
    // TODO: implement build
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Sign In'
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              signInButton(),
            ],
          ),
        ),
      ),
    );
    
  }
}