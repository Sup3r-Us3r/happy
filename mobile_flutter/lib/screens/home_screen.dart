import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapController _mapController = MapController();

  bool _infoWindowVisible = false;

  void _selectOnMap() {
    // _mapController;
  }

  void _handleToggleWindow() {
    setState(() {
      _infoWindowVisible = !_infoWindowVisible;
    });
  }

  Opacity _popupMarker(BuildContext context) {
    return Opacity(
      opacity: _infoWindowVisible ? 1.0 : 0.0,
      child: GestureDetector(
        onTap: () => _handleToggleWindow(),
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
                      'Orfanato',
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
                      onPressed: () {},
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

  Opacity _marker() {
    return Opacity(
      opacity: _infoWindowVisible ? 0.0 : 1.0,
      child: GestureDetector(
        onTap: () => _handleToggleWindow(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(-19.6264507, -43.2339631),
              zoom: 13.0,
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
                    width: 300.0,
                    point: LatLng(-19.6264507, -43.2339631),
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          _popupMarker(context),
                          _marker(),
                        ],
                      );
                    },
                  ),
                ],
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
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      '3 orfanatos encontrados',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[300],
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
                        onPressed: () {},
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
