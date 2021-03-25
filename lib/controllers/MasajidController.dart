// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:tausug_tafseer/style/Hex.dart';

Marker recodoLappasan = (new Marker(
    width: 45.0,
    height: 45.0,
    point: new LatLng(6.9548033, 121.9598906),
    builder: (context) => new Container(
            child: Transform.scale(
          scale: 1.5,
          child: IconButton(
            icon: new Image.asset("images/Masjid_Marker.png"),
            onPressed: () {
              print('Test123');
            },
          ),
        ))));

Marker recodoDarusSalam = (new Marker(
    width: 45.0,
    height: 45.0,
    point: new LatLng(6.954197, 121.9599458),
    builder: (context) => new Container(
            child: Transform.scale(
          scale: 1.5,
          child: IconButton(
            icon: new Image.asset("images/Masjid_Marker.png"),
            onPressed: () {
              print('Test123');
            },
          ),
        ))));

Marker recodoKasalamatan = (new Marker(
    width: 45.0,
    height: 45.0,
    point: new LatLng(6.9536097, 121.9603251),
    builder: (context) => new Container(
            child: Transform.scale(
          scale: 1.5,
          child: IconButton(
            icon: new Image.asset("images/Masjid_Marker.png"),
            onPressed: () {
              print('Test123');
            },
          ),
        ))));

Marker recodoAwwal = (new Marker(
    width: 45.0,
    height: 45.0,
    point: new LatLng(6.9536097, 121.9603251),
    builder: (context) => new Container(
            child: Transform.scale(
          scale: 1.5,
          child: IconButton(
            icon: new Image.asset("images/Masjid_Marker.png"),
            onPressed: () {
              print('Test123');
            },
          ),
        ))));

Marker recodoLanjang = (new Marker(
    width: 45.0,
    height: 45.0,
    point: new LatLng(6.9532783, 121.9602644),
    builder: (context) => new Container(
            child: Transform.scale(
          scale: 1.5,
          child: IconButton(
            icon: new Image.asset("images/Masjid_Marker.png"),
            onPressed: () {
              print('Test123');
            },
          ),
        ))));

CircleMarker atTaawunCircleMarker = (new CircleMarker(
    point: LatLng(6.969055, 121.943253),
    color: Color(hexColor('#216353')).withOpacity(0.2),
    borderStrokeWidth: 1.0,
    borderColor: Colors.redAccent,
    radius: 60));
