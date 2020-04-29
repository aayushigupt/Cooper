import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:html';
import 'dart:math';
//import 'package:demoji/demoji.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  double _newValue = 0;

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(27.2038, 77.5011), zoom: 15);
  GoogleMapController _controller;
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  final List<Marker> markers = [];
  addMarker(coordinate) {
    _addGeoPoint(coordinate);
    int id = Random().nextInt(100);
    FlatButton(
        child: Icon(
          Icons.pin_drop,
          color: Colors.white,
        ),
        color: Colors.green,
        onPressed: () {
          _addGeoPoint(coordinate);
          _userLocation(coordinate);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext) => RatingDialogAlert(),
              ));
        });
    setState(() {
      markers
          .add(Marker(position: coordinate, markerId: MarkerId(id.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        myLocationEnabled: true,
        compassEnabled: true,
        markers: markers.toSet(),
        onTap: (coordinate) {
          _controller.animateCamera(CameraUpdate.newLatLng(coordinate));
          addMarker(coordinate);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext) => RatingDialogAlert(),
              ));
        },
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(top: 120.0),
        child: Align(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                markers.clear();
              });
            },
            child: Icon(Icons.remove),
          ),
          alignment: Alignment.topRight,
        ),
      ),
    );
  }

  void _addGeoPoint(coordinates) async {
    GeoFirePoint point = geo.point(
        latitude: coordinates.latitude, longitude: coordinates.longitude);
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await firestore
        .collection('locations')
        .add({'position': point.data, 'name': 'Yay!!', 'userID': user.uid});
  }
   void _userLocation(coordinates) async {
     FirebaseUser user = await FirebaseAuth.instance.currentUser();
 
    await firestore
        .collection('locations').document(user.uid).setData(coordinates);
       
  }

  createDialog(BuildContext context) {
    return showDialog(
        context: context, builder: (context) => RatingDialogAlert());
  }
}

class RatingDialogAlert extends StatefulWidget {
  @override
  RatingDialogAlertState createState() => RatingDialogAlertState();
}

class RatingDialogAlertState extends State<RatingDialogAlert> {
  var _newValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Rate the amount of Severity',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                fontSize: 18.0,
              )),
            ),
            SizedBox(
              height: 22.0,
            ),
            SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red[700],
                  inactiveTrackColor: Colors.red[100],
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 4.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  thumbColor: Colors.redAccent,
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  tickMarkShape: RoundSliderTickMarkShape(),
                  activeTickMarkColor: Colors.red[700],
                  inactiveTickMarkColor: Colors.red[100],
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Colors.redAccent,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Slider(
                    value: _newValue,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: '$_newValue',
                    onChanged: (_value) => setState(() => _newValue = _value))),
            Container(
              height: 25.0,
              width: 100.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Text('Done'),
                color: Colors.pink[600],
                onPressed: () async {
                  print(_newValue);
                  var collectionRef = Firestore.instance.collection("details");
                  Map<String, dynamic> details = {
                    "rating": _newValue,
                  };
                  await collectionRef.add(details);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }
}
