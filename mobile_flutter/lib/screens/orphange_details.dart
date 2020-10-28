import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mobile_flutter/screens/home_screen.dart';
import 'package:mobile_flutter/widgets/map_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class OrphanageDetails extends StatefulWidget {
  final int id;

  OrphanageDetails({this.id});

  @override
  _OrphanageDetailsState createState() => _OrphanageDetailsState();
}

class _OrphanageDetailsState extends State<OrphanageDetails> {
  Map _orphanage = new Map();
  List _orphanageImages = [];
  bool _openOnWeekends = true;
  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  void initState() {
    super.initState();

    _getOrphanage().then((orphanage) {
      for (var image in orphanage['images']) {
        _orphanageImages.add(image);
      }

      setState(() {
        _orphanage = orphanage;
        _openOnWeekends = orphanage['open_on_weekends'];
        _latitude = orphanage['latitude'];
        _longitude = orphanage['longitude'];
      });
    });
  }

  Future<Map> _getOrphanage() async {
    Dio dio = new Dio();
    final String baseUrl = 'http://192.168.2.8:3333';

    Response response = await dio.get('$baseUrl/orphanages/${widget.id}');

    return response.data;
  }

  void _handleGoBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Future _handleOpenWhatsApp() async {
    final String _phone = '5500912345678';
    final String _message = 'Em que posso ajudar?';
    final String _whatsappUrl = Platform.isAndroid
        ? 'whatsapp://send?phone=+$_phone&text=${Uri.parse(_message)}'
        : 'whatsapp://wa.me/$_phone/?text=${Uri.parse(_message)}';

    if (await canLaunch(_whatsappUrl)) {
      launch(_whatsappUrl);
    } else {
      throw 'Could not launch url.';
    }
  }

  Container _slideImages(BuildContext context) {
    return Container(
      height: 300.0,
      width: double.infinity,
      color: Colors.transparent,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _orphanageImages.length,
        itemBuilder: (BuildContext context, int index) {
          final image = _orphanageImages != null ? _orphanageImages[index] : '';
          return _orphanage != null
              ? Image.network(
                  image['url'],
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                )
              : Container();
        },
      ),
    );
  }

  Container _cardInfo(
    String text,
    Color textColor,
    IconData icon,
    Color iconColor,
    List<Color> gradiendColors,
    Color borderColor,
  ) {
    return Container(
      height: 160.0,
      width: 160.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        gradient: LinearGradient(
          colors: gradiendColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 35.0,
            ),
            SizedBox(height: 10.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                color: textColor,
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
      appBar: AppBar(
        title: Text(
          'Orfanato',
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _slideImages(context),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    '${_orphanage['name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                      fontSize: 35.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '${_orphanage['about']}',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _latitude != 0.0
                      ? MapDetail(
                          latitude: _latitude,
                          longitude: _longitude,
                        )
                      : SizedBox(),
                  Divider(
                    height: 40.0,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Instruções de visita',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '${_orphanage['instructions']}',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _cardInfo(
                        '${_orphanage['opening_hours']}',
                        Colors.blueGrey,
                        Icons.access_time,
                        Theme.of(context).accentColor,
                        [Color(0xFFE6F7FB), Color(0xFFFFFFFF)],
                        Color(0xFFB3DAE2),
                      ),
                      _openOnWeekends
                          ? _cardInfo(
                              'Atendemos fim de semana',
                              Color(0xFF37C77F),
                              Icons.access_time,
                              Color(0xFF37C77F),
                              [Color(0xFFEDFFF6), Color(0xFFFFFFFF)],
                              Color(0xFFA1E9C5),
                            )
                          : _cardInfo(
                              'Não atendemos fim de semana',
                              Color(0xFFFF669D),
                              Icons.info_outline,
                              Color(0xFFFF669D),
                              [Color(0xFFFCEFF4), Color(0xFFFFFFFF)],
                              Color(0xFFFFBCD4),
                            ),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      child: RaisedButton(
                        onPressed: () => _handleOpenWhatsApp(),
                        color: Color(0xFF3CDC8C),
                        highlightColor: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.green[500],
                              size: 35.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Entrar em contato',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
