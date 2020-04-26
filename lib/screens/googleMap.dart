// import 'dart:html';
import 'dart:math';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget
{
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final CameraPosition _initialPosition = CameraPosition(target:LatLng(27.2038, 77.5011), zoom:15 );
  GoogleMapController _controller;
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  final List<Marker> markers =[];
  addMarker(coordinate)
  {
    _addGeoPoint(coordinate);
    int id = Random().nextInt(100);
    FlatButton(
      child: Icon(Icons.pin_drop, color: Colors.white,),
      color: Colors.green,
      onPressed: () => _addGeoPoint(coordinate),
    );
    setState(() {
     markers.add(Marker(position: coordinate, markerId: MarkerId(id.toString())) );
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
        onMapCreated: (controller){
          setState((){
            _controller = controller;
          });
         
        },
        myLocationEnabled: true,
        compassEnabled: true,
        
        markers: markers.toSet(),
         onTap: (coordinate){
            _controller.animateCamera(CameraUpdate.newLatLng(coordinate));
            addMarker(coordinate);
          },
      ),
     
      
    );
  }
  void  _addGeoPoint(coordinates) async{
    GeoFirePoint point = geo.point(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude
    );
    await firestore.collection('locations').add({
      'position' : point.data,
      'name': 'Yay!!'
    });

  }
}