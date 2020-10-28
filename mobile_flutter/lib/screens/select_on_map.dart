import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mobile_flutter/screens/create_orphanage.dart';
import 'package:mobile_flutter/screens/home_screen.dart';

class SelectOnMap extends StatefulWidget {
  @override
  _SelectOnMapState createState() => _SelectOnMapState();
}

class _SelectOnMapState extends State<SelectOnMap> {
  Marker _tapMarker;
  LatLng _currentLatLng;

  void _selectOnMap(BuildContext context, LatLng coordinates) {
    setState(() {
      _currentLatLng = coordinates;

      _tapMarker = Marker(
        height: 60.0,
        width: 300.0,
        point: coordinates,
        builder: (BuildContext context) {
          return _marker();
        },
      );
    });
  }

  Container _marker() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        'assets/images/map-marker.png',
        height: 60.0,
        width: 60.0,
      ),
    );
  }

  void _handleGoBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void _handleNavigateToCreateOrphanage(
      BuildContext context, LatLng coordinates) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateOrphanage(coordinates: coordinates),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicione um orfanato',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[400],
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).accentColor,
            size: 35.0,
          ),
          onPressed: () => _handleGoBack(context),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          FlutterMap(
            // mapController: _mapController,
            options: MapOptions(
              center: LatLng(-19.6264507, -43.2339631),
              zoom: 13.0,
              onTap: (LatLng coordinates) => _selectOnMap(context, coordinates),
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
                  _tapMarker != null ? _tapMarker : Marker(),
                ],
              ),
            ],
          ),
          Visibility(
            visible: _tapMarker == null ? false : true,
            child: Positioned(
              bottom: 20.0,
              child: Container(
                alignment: Alignment.center,
                height: 60.0,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: RaisedButton(
                      onPressed: () => _handleNavigateToCreateOrphanage(
                          context, _currentLatLng),
                      color: Theme.of(context).accentColor,
                      highlightColor: Colors.transparent,
                      elevation: 0.0,
                      child: Text(
                        'Próximo',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
