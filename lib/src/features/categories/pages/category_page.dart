import 'package:carshop/src/features/categories/blocs/categories_bloc.dart';
import 'package:carshop/src/models/category.dart';
import 'package:carshop/src/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:carshop/src/utils/utils.dart' as utils;
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Category category;
  bool _guardando = false;
  CategoriesBloc bloc;

  @override
  Widget build(BuildContext context) {
    category = new Category();
    bloc = Provider.of<SessionProvider>(context).categoriesBloc;

    final Category data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      category = data;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Categoría'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                _txtNombre(),
                _permisoEscritura(),
                _permisoLectura(),
                _permisoEdicion(),
                SizedBox(
                  height: 16.0,
                ),
                _btnSubmit(context)
                //_crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _txtNombre() {
    return TextFormField(
      initialValue: '${category.name ?? ''}',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Nombre de categoía'),
      validator: (value) {
        if (value.isEmpty) return 'Ingrese una categoía';
        if (!utils.isValidText(value)) return 'Ingrese solo letras';
        return null;
      },
      onSaved: (value) => category.name = value,
    );
  }

  Widget _permisoEscritura() {
    // Check box con titulo.
    return SwitchListTile(
        title: Text('Permiso de escritura',
            style: TextStyle(
                fontSize: 14.0, color: Theme.of(context).accentColor)),
        value: (category.write == 0) ? false : true,
        onChanged: (value) {
          setState(() {
            category.write = (value) ? 1 : 0;
          });
        });
  }

  Widget _permisoLectura() {
    // Check box con titulo.
    return SwitchListTile(
        title: Text('Permiso de lectura',
            style: TextStyle(
                fontSize: 14.0, color: Theme.of(context).accentColor)),
        value: (category.read == 0) ? false : true,
        onChanged: (value) {
          setState(() {
            category.read = (value) ? 1 : 0;
          });
        });
  }

  Widget _permisoEdicion() {
    // Check box con titulo.
    return SwitchListTile(
        title: Text('Permiso de edición',
            style: TextStyle(
                fontSize: 14.0, color: Theme.of(context).accentColor)),
        value: (category.edit == 0) ? false : true,
        onChanged: (value) {
          setState(() {
            category.edit = (value) ? 1 : 0;
          });
        });
  }

  Widget _btnSubmit(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.save, color: Theme.of(context).secondaryHeaderColor),
      label: Text('Guardar'),
      onPressed: (_guardando) ? null : _submit,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).accentColor,
      textColor: Theme.of(context).secondaryHeaderColor,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    print('TODO OK');
    print('Categoria              :${category.name}');
    print('Permiso de escritura   :${category.write}');
    print('Permiso de lectura     :${category.read}');
    print('Permiso de edición     :${category.edit}');

    if (category.id == null) {
      bloc.agregarCategoria(category);
    } else {
      bloc.actualizarCategoria(category);
    }

    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
      //backgroundColor: Colors.teal,
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
