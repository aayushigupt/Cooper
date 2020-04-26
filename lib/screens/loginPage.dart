import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flare_flutter/flare_actor.dart';
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
  

      child: new RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0)
        ),
color: Colors.blue,
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
        child: Container(
       color: Colors.blue,

          height:50,
          width:190,
          child: Form(
            child: Row(
              
              children: <Widget>[
                
                Container(
                 
                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text('Sign with',
                  
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  
                  ),
                ),
                
                   Container(
                       padding: EdgeInsets.only(left: 49.0),
                     child: Image.asset("assets/google_logo.png",
                       
                       ),
                     ),
                

              ],
            ),
          )
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