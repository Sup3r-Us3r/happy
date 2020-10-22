import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class CreateOrphanage extends StatefulWidget {
  @override
  _CreateOrphanageState createState() => _CreateOrphanageState();
}

class _CreateOrphanageState extends State<CreateOrphanage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _openingHoursController = TextEditingController();

  Dio dio = new Dio();
  bool _toggleSwitch = true;
  File _image;
  List<File> _listImages = [];

  void _handleSubmit(String imagePath) async {
    try {
      const String baseUrl = 'http://192.168.2.8:3333';
      Response response = await dio.get('$baseUrl/orphanages');
      print(response.data);

      // Images
      String filename = imagePath.split('/').last;
      String fileExtension = filename.split('.').last;

      FormData formData = FormData.fromMap({
        'name': _nameController.value,
        'latitude': 111111,
        'longitude': 222222,
        'about': _aboutController.value,
        'instructions': _instructionsController.value,
        'opening_hours': _openingHoursController.value,
        'open_on_weekends': _toggleSwitch,
        'images': await MultipartFile.fromFile(
          imagePath,
          filename: filename,
          contentType: MediaType('image', fileExtension),
        ),
        'type': 'image/$fileExtension',
      });

      Response response2 = await dio.post(
        '$baseUrl/orphanages',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      print(response2.data);
    } catch (err) {
      print(err);
    }
  }

  Future _getImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (image.path != null) {
        _image = File(image.path);
        _listImages.add(File(image.path));
      }
    });
  }

  Container _containerField(TextField child,
      {Alignment containerAlignment: Alignment.center,
      double containerHeight: 60.0,
      double containerPadding: 0.0}) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(
        vertical: containerPadding,
        horizontal: 20.0,
      ),
      alignment: containerAlignment,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.green[100],
          width: 1.2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: child,
    );
  }

  void _removeImage(int index) {
    setState(() {
      _listImages.removeAt(index);
    });
  }

  Widget _imageBuilder(BuildContext context, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Stack(
        children: [
          Image.file(
            _listImages[index],
            height: 90.0,
            width: 90.0,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: -5.0,
            right: -5.0,
            child: GestureDetector(
              onTap: () => _removeImage(index),
              child: Container(
                height: 40.0,
                width: 40.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                  ),
                ),
                child: Icon(
                  Icons.close,
                  color: Color(0xFFFF669D),
                  size: 25.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: Color(0xFFFF669D),
                size: 28.0,
              ),
              onPressed: () {},
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dados',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 28.0,
                ),
              ),
              Divider(
                height: 40.0,
                color: Colors.grey[400],
              ),
              Text(
                'Nome',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                ),
              ),
              _containerField(
                TextField(
                  style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration.collapsed(hintText: null),
                  controller: _nameController,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sobre',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    'Máximo de 300 caracteres',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              _containerField(
                TextField(
                  style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration.collapsed(hintText: null),
                  controller: _aboutController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
                containerAlignment: Alignment.topLeft,
                containerHeight: 160.0,
                containerPadding: 10.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Fotos',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                height: 60.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  border: Border.all(
                    color: Colors.green[100],
                    width: 1.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: RaisedButton(
                    onPressed: _getImage,
                    color: Colors.white,
                    highlightColor: Colors.white,
                    elevation: 0.0,
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).accentColor,
                      size: 35.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              _listImages.length != 0
                  ? Container(
                      padding: EdgeInsets.all(7.0),
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(
                          color: Colors.green[100],
                          width: 1.0,
                        ),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _listImages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            child: _imageBuilder(context, index),
                          );
                        },
                      ),
                    )
                  : Container(),
              SizedBox(height: 70.0),
              Text(
                'Visitação',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 28.0,
                ),
              ),
              Divider(
                height: 40.0,
                color: Colors.grey[400],
              ),
              Text(
                'Instruções',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                ),
              ),
              _containerField(
                TextField(
                  style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration.collapsed(hintText: null),
                  controller: _instructionsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
                containerAlignment: Alignment.topLeft,
                containerHeight: 160.0,
                containerPadding: 10.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Horário de visita',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                ),
              ),
              _containerField(
                TextField(
                  style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration.collapsed(hintText: null),
                  controller: _openingHoursController,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Atende fim de semana?',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                  ),
                  Switch(
                    value: _toggleSwitch,
                    onChanged: (bool switchChange) {
                      setState(() {
                        if (switchChange) {
                          _toggleSwitch = true;
                        } else {
                          _toggleSwitch = false;
                        }
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Color(0xFF39CC83),
                    inactiveThumbColor: Color(0xFF8FA7B3),
                    inactiveTrackColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Container(
                height: 60.0,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: RaisedButton(
                    onPressed: () {},
                    elevation: 0.0,
                    child: Text(
                      'Próximo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    color: Theme.of(context).accentColor,
                    highlightColor: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
