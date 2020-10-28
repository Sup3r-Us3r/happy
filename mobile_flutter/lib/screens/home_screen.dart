import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mobile_flutter/screens/orphange_details.dart';
import 'package:mobile_flutter/screens/select_on_map.dart';

import '../models/orphange_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Marker> _markersOnMap = [];
  int _togglePopup;

  @override
  void initState() {
    super.initState();

    _togglePopup = -1;

    _getOrphanages().then((data) {
      for (var orphanage in data) {
        _markersOnMap.add(
          Marker(
            height: 60.0,
            width: 300.0,
            point: LatLng(orphanage['latitude'], orphanage['longitude']),
            builder: (BuildContext context) {
              return Stack(
                children: [
                  _popupMarker(context, orphanage['id'], orphanage['name']),
                  _marker(orphanage['id']),
                ],
              );
            },
          ),
        );
      }

      setState(() {
        _markersOnMap = _markersOnMap;
      });
    });
  }

  Future<List> _getOrphanages() async {
    Dio dio = new Dio();
    final String baseUrl = 'http://192.168.2.8:3333';

    Response response = await dio.get('$baseUrl/orphanages');

    return (response.data as List)
        .map((data) => Orphanage.fromJson(data).toJson())
        .toList();
  }

  void _handleToggleWindow(int id) {
    setState(() {
      _togglePopup = id;
    });
  }

  void _handleNavigateToOrphanageDetails(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrphanageDetails(id: id)),
    );
  }

  void _handleNavigateToSelectOnMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectOnMap()),
    );
  }

  Opacity _marker(int id) {
    return Opacity(
      opacity: _togglePopup == id ? 0.0 : 1.0,
      child: GestureDetector(
        onTap: () => _handleToggleWindow(id),
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/images/map-marker.png',
            height: 60.0,
            width: 60.0,
          ),
        ),
      ),
    );
  }

  Opacity _popupMarker(BuildContext context, int id, String name) {
    return Opacity(
      opacity: _togglePopup == id ? 1.0 : 0.0,
      child: GestureDetector(
        onTap: () => _handleToggleWindow(id),
        child: Stack(
          alignment: Alignment.center,
          overflow: Overflow.visible,
          children: [
            Container(
              height: 60.0,
              width: 300.0,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 170.0,
                    child: Text(
                      '$name',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0089A5),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      highlightColor: Colors.transparent,
                      elevation: 0.0,
                      onPressed: () =>
                          _handleNavigateToOrphanageDetails(context, id),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -35,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.white.withOpacity(0.7),
                size: 60.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(-19.6264507, -43.2339631),
              zoom: 13.0,
              onTap: (_) {
                setState(() {
                  _togglePopup = -1;
                });
              },
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoibWF5ZGVyc29uIiwiYSI6ImNrZzlodHFoczA5a2kycnAyNnRydHVwcGcifQ.teUri0hVYZYDi-K0iKoI3A',
                },
              ),
              MarkerLayerOptions(
                markers: _markersOnMap != null ? _markersOnMap : [],
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            child: Container(
              alignment: Alignment.center,
              height: 60.0,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      '${_markersOnMap.length} orfanatos encontrados',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      child: RaisedButton(
                        onPressed: () => _handleNavigateToSelectOnMap(context),
                        color: Theme.of(context).accentColor,
                        highlightColor: Colors.transparent,
                        elevation: 0.0,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
