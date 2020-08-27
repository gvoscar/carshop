import 'package:carshop/src/configs/user_preferences.dart';
import 'package:carshop/src/features/categories/pages/categories_page.dart';
import 'package:carshop/src/features/vehicles/pages/vehicle_page.dart';
import 'package:carshop/src/features/vehicles/pages/vehicles_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = UserPreferences();
  int paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CarShop'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.playlist_add),
              onPressed: () {
                Navigator.pushNamed(context, 'category');
              })
        ],
      ),
      body: _cargarPagina(paginaActual),
      // Metodo para crear la barra de navegacion inferior.
      bottomNavigationBar: _crearBottomNavigationBar(),
      // Centrar boton flotante.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Metodo para crear el boton flotante.
      floatingActionButton: _crearFloatingActionButton(context),
    );
  }

  /// Metodo para cargar la pagina que indica la barra de navegacion inferior.
  Widget _cargarPagina(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return VehiclesPage();
      case 1:
        return CategoriesPage();

      default:
        return VehiclesPage();
    }
  }

  /// Metodo para crear la barra de navegacion inferior.
  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: paginaActual,
      onTap: (index) {
        setState(() {
          paginaActual = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.car), title: Text('Vehículos')),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.list), title: Text('Categorías')),
      ],
    );
  }

  /// Metodo para crear el boton flotante.
  Widget _crearFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add_circle_outline),
      onPressed: () {
        //=> _scanQR(context)
        Navigator.pushNamed(context, 'vehicle');
      },
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}
