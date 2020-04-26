import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:testing/screens/check.dart';
class Register extends StatefulWidget
{
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController nameController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController commentController = TextEditingController();

Widget name()
{

  return Container(
    width: 430,
    child: TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: 'Full Name',

      ),
    ),
  );
}

Widget aadhar()
{
  return Container(
    width: 430,
    child: TextFormField(
      controller: aadharController,
      decoration: InputDecoration(
        labelText: 'Aadhar Card Number'
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
        backgroundColor: Colors.orange,
        title: Text('Registeration'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0,),
                name(),
                SizedBox(height: 40.0,),
                aadhar(),
                SizedBox(height: 40.0,),
                problem(),
                SizedBox(height: 40.0,),
                comment(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          var collectionRef = Firestore.instance.collection("detail");
          Map<String, dynamic> detail = {
            "name": nameController.text,
            "aadhar": aadharController.text,
            "problems": problemController.text,
            "comment": commentController.text,
          };
          await collectionRef.add(detail);
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext)=> Check(),
          ));
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.done),
      ),
    );
  }
}