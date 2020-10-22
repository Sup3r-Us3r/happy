import 'package:flutter/material.dart';

class OrphanageDetails extends StatefulWidget {
  @override
  _OrphanageDetailsState createState() => _OrphanageDetailsState();
}

class _OrphanageDetailsState extends State<OrphanageDetails> {
  Container _slideImages(BuildContext context) {
    return Container(
      height: 300.0,
      width: double.infinity,
      color: Colors.transparent,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://bit.ly/34iZYM0',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          );
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
          onPressed: () {},
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
                    'Orfanato',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                      fontSize: 35.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Presta assistência a crianças de 06 a 15 anos que se encontre em situação de risco e/ou vulnerabilidade social.',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                  ),
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
                    'Venha quando sentir a vontade, e traga muito amor e paciência para dar.',
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
                        'Segunda à Sexta de 8h às 18h',
                        Colors.blueGrey,
                        Icons.access_time,
                        Theme.of(context).accentColor,
                        [Color(0xFFE6F7FB), Color(0xFFFFFFFF)],
                        Colors.green[400],
                      ),
                      _cardInfo(
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
                        onPressed: () {},
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
