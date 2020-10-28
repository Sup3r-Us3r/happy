import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapDetail extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapDetail({this.latitude, this.longitude});

  @override
  _MapDetailState createState() => _MapDetailState();
}

class _MapDetailState extends State<MapDetail> {
  Future _handleOpenLinkOnBrowser(LatLng coordinates) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${coordinates.latitude},${coordinates.longitude}';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleOpenLinkOnBrowser(
        LatLng(widget.latitude, widget.longitude),
      ),
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          color: Color(0xFFE6F7FB),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(
            color: Color(0xFFDDE3F0),
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(widget.latitude, widget.longitude),
                    zoom: 15.0,
                    interactive: false,
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
                      markers: [
                        Marker(
                          height: 60.0,
                          width: 60.0,
                          point: LatLng(widget.latitude, widget.longitude),
                          builder: (BuildContext context) {
                            return Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                'assets/images/map-marker.png',
                                height: 60.0,
                                width: 60.0,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Text(
                  'Ver rotas no Google Maps',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0089A5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
