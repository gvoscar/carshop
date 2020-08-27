import 'package:carshop/src/configs/user_preferences.dart';
import 'package:carshop/src/features/signin/bloc/signin_bloc.dart';
import 'package:carshop/src/features/signin/events/signin_event.dart';
import 'package:carshop/src/providers/session_provider.dart';
import 'package:carshop/src/providers/theme_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: <Widget>[
            _construirFondo(context),
            _construirFormulario(context),
          ],
        ));
  }

  Widget _construirFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Theme.of(context).primaryColor,
        Theme.of(context).accentColor,
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            children: <Widget>[
              Icon(FontAwesomeIcons.car, color: Colors.white, size: 50.0),
              SizedBox(height: 5.0, width: double.infinity),
              Text('CarShop',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  Widget _construirFormulario(BuildContext context) {
    final bloc = Provider.of<SessionProvider>(context).signinBloc;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 120.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Iniciar sesión', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 20.0),
                _txtEmail(bloc),
                SizedBox(height: 10.0),
                _txtPassword(bloc),
                SizedBox(height: 10.0),
                _crearSwitch(bloc, context),
                SizedBox(height: 32.0),
                _btnSubmit(bloc, context)
              ],
            ),
          ),
          FlatButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'signup'),
              child: Text('Crear una cuenta',
                  style: TextStyle(color: Theme.of(context).accentColor))),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _txtEmail(SigninBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _txtPassword(SigninBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline),
                labelText: 'Contraseña',
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _btnSubmit(SigninBloc bloc, BuildContext context) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Theme.of(context).accentColor,
            textColor: Theme.of(context).secondaryHeaderColor,
            onPressed:
                snapshot.hasData ? () => _ingresar(bloc, context) : null);
      },
    );
  }

  Widget _crearSwitch(SigninBloc bloc, BuildContext context) {
    // Check box con titulo.
    return StreamBuilder(
        stream: bloc.themeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return Container(
            child: SwitchListTile(
                title: Text('Modo oscuro',
                    style: TextStyle(
                        fontSize: 14.0, color: Theme.of(context).accentColor)),
                value: bloc.theme,
                onChanged: (value) => _cambiarTema(value, bloc, context)),
          );
        });
  }

  _cambiarTema(bool value, SigninBloc bloc, BuildContext context) {
    final themeProvider =
        Provider.of<ThemeChangeProvider>(context, listen: false);
    if (!value) {
      themeProvider.setTheme(ThemeData.light());
    } else {
      themeProvider.setTheme(ThemeData.dark());
    }
    bloc.themeChange(value);
  }

  _ingresar(SigninBloc bloc, BuildContext context) async {
    print('================');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('================');

    // Map result = await usuarioProvider.login(bloc.email, bloc.password);
    final prefs = UserPreferences();
    final result = await bloc.signin(bloc.email, bloc.password);

    if (result.eventType == SigninEvent.ERROR) {
      _showError(result.message);
      return;
    }

    prefs.email = result.user.email;
    Navigator.pushReplacementNamed(context, 'home');
  }

  void _showError(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
