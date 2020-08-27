import 'package:animate_do/animate_do.dart';
import 'package:carshop/src/configs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _initLoader(context);
    return Scaffold(
      body: Stack(
        children: [
          _logo(context),
          _titulo(context),
          _descripcion(context),
        ],
      ),
    );
  }

  void _initLoader(
    BuildContext context,
  ) async {
    await Future.delayed(Duration(seconds: 5), () {
      //print('3 segundos');
    });

    final prefs = UserPreferences();

    if (prefs.email == '') {
      print('Usuario no autenticado');
      _navigatorTo(context, 'signin');
    }

    if (prefs.email != '') {
      print('Usuario autenticado');
      _navigatorTo(context, 'home');
    }
  }

  void _navigatorTo(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  Widget _logo(BuildContext context) {
    return Bounce(
      infinite: true,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 32.0),
          height: 80,
          width: double.infinity,
          child: Icon(FontAwesomeIcons.car,
              size: 50.0, color: Theme.of(context).accentColor),
        ),
      ),
    );
  }

  Widget _titulo(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 162.0),
        child: Text(
          'CarShop',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _descripcion(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Spacer(),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'Cargando...',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(height: 10.0),
          LinearProgressIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          )
        ],
      ),
    );
  }
}
