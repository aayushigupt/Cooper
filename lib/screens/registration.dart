import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:testing/screens/check.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Register extends StatefulWidget
{
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController solutionController = TextEditingController();
  TextEditingController affectController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController commentController = TextEditingController();

Widget solution()
{

  return Container(
    width: 430,
    child: TextFormField(
      controller: solutionController,
      decoration: InputDecoration(
        labelText: 'Solution',
        hintText: 'Any solution if you can suggest!!'
      ),
    ),
  );
}

Widget affect()
{
  return Container(
    width: 430,
    child: TextFormField(
      controller: affectController,
      decoration: InputDecoration(
        labelText: 'Presence of Most Affected Thing'
      ),
    ),
  );
}

Widget problem()
{
  return Container(
    width: 430,
    child: TextFormField(
      controller: problemController,
      decoration: InputDecoration(
        labelText: 'Problems',
        hintText: 'What kind of problems you have seen there',
      ),
    ),
  );
}
Widget comment()
{
  return Container(
    width: 430,
    child: TextFormField(
      controller: commentController,
      decoration: InputDecoration(
        labelText: 'Comments',
        hintText: 'Leave Your Comments',
      ),
    ),
  );

}
void initState()
{
 
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        title: Text('Registeration'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 60.0,),
                problem(),
                SizedBox(height: 50.0,),
                affect(),
                SizedBox(height: 50.0,),
                solution(),
                SizedBox(height: 50.0,),
                comment(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          var collectionRef = Firestore.instance.collection("detail");
          FirebaseUser user = await FirebaseAuth.instance.currentUser();
          Map<String, dynamic> detail = {
            "solution": solutionController.text,
            "affect": affectController.text,
            "problems": problemController.text,
            "comment": commentController.text,
            "uid": user.uid,
          };
          
          await collectionRef.add(detail);
          
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext)=> Check(),
          ));
        },
        backgroundColor: Colors.pink[600],
        child: Icon(Icons.done),
      ),
    );
  }
}