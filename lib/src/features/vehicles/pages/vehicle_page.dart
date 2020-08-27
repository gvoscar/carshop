import 'dart:io';

import 'package:carshop/src/features/categories/blocs/categories_bloc.dart';
import 'package:carshop/src/features/vehicles/blocs/vehicles_bloc.dart';
import 'package:carshop/src/models/category.dart';
import 'package:carshop/src/models/vehicle.dart';
import 'package:carshop/src/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carshop/src/utils/utils.dart' as utils;
import 'package:provider/provider.dart';

class VehiclePage extends StatefulWidget {
  @override
  _VehiclePageState createState() => _VehiclePageState();
}

enum VehiculoNuevo { si, no }

class _VehiclePageState extends State<VehiclePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Vehicle vehicle = new Vehicle();
  bool _guardando = false;

  Category _categorySelected;
  File _image;
  final _imagePicker = ImagePicker();
  VehiculoNuevo _vehiculoNuevo = VehiculoNuevo.si;
  int _categoriaId = 1;

  VehiclesBloc bloc;
  CategoriesBloc categoriasBloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<SessionProvider>(context).vehiclesBloc;
    categoriasBloc = Provider.of<SessionProvider>(context).categoriesBloc;
    //categoriasBloc.cargarCategorias();
    final Vehicle vehicleData = ModalRoute.of(context).settings.arguments;

    if (vehicleData != null) {
      vehicle = vehicleData;
      _categoriaId = int.parse(vehicle.categoryId);
      if (vehicle.categoryId != null) {
        _consultarCategoria(categoriasBloc);
      }
    }

    _vehiculoNuevo = (vehicle.used == 0) ? VehiculoNuevo.no : VehiculoNuevo.si;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Vehículo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                SizedBox(
                  height: 16.0,
                ),
                _txtOcupantes(),
                _txtPrecio(),
                _radioNuevo(),
                _txtModelo(),
                _categoria(),
                _datoExtra(),
                SizedBox(
                  height: 32.0,
                ),
                _btnSubmit(context),
                SizedBox(
                  height: 32.0,
                ),
                //_crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _consultarCategoria(CategoriesBloc categoriasBloc) async {
    print('_consultarCategoria');
    vehicle.category =
        await categoriasBloc.consultarCategoria(vehicle.categoryId);
    print('Categoria actual de vehiculo: ${vehicle.category.name}');
    //setState(() {});
  }

  _seleccionarFoto() {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() {
    // tomar foto.
    _procesarImagen(ImageSource.camera);
  }

  // procesar imagen
  _procesarImagen(ImageSource imageSource) async {
    final pickedFile = await _imagePicker.getImage(source: imageSource);
    _image = File(pickedFile.path);

    if (_image != null) {
      vehicle.photoUrl = null;
    }

    setState(() {});
  }

  _mostrarFoto() {
    if (vehicle.photoUrl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/loading.gif'),
        image: NetworkImage(vehicle.photoUrl),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      if (_image?.path != null) {
        return Image.file(
          _image,
          fit: BoxFit.cover,
          height: 300.0,
        );
      } else {
        return Image.asset('assets/no-imagen.png');
      }
    }
  }

  Widget _txtOcupantes() {
    return TextFormField(
      initialValue: '${vehicle.occupants}',
      // textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Cantidad de asientos'),
      validator: (value) {
        if (!utils.isValidNumber(value)) {
          return 'Ingrese solo números';
        }
        if ((int.parse(value)) <= 0) {
          return 'Ingresa la cantidad de asientos';
        }
        return null;
      },
      onSaved: (value) => vehicle.occupants = int.parse(value),
    );
  }

  Widget _txtPrecio() {
    return TextFormField(
      initialValue: '${vehicle.price}',
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (value) {
        if (!utils.isNumeric(value)) {
          return 'No es un valor valido.';
        }
        if ((double.parse(value)) <= 0) {
          return 'Ingresa un precio';
        }
        return null;
      },
      onSaved: (value) => vehicle.price = double.parse(value),
    );
  }

  Widget _radioNuevo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '¿Este vehículo es usado?',
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RadioListTile(
                  title: Text('Sí'),
                  value: VehiculoNuevo.si,
                  groupValue: _vehiculoNuevo,
                  onChanged: (VehiculoNuevo value) {
                    setState(() {
                      _vehiculoNuevo = value;
                      vehicle.used = 1;
                    });
                  }),
              RadioListTile(
                  title: Text('No'),
                  value: VehiculoNuevo.no,
                  groupValue: _vehiculoNuevo,
                  onChanged: (VehiculoNuevo value) {
                    setState(() {
                      _vehiculoNuevo = value;
                      vehicle.used = 0;
                    });
                  }),
            ],
          ),
        )
      ],
    );
  }

  Widget _txtModelo() {
    return TextFormField(
      initialValue: '${vehicle.model}',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Modelo'),
      validator: (value) {
        if (value.isEmpty) return 'Ingrese un modelo';
        if (!utils.isValidText(value)) return 'Ingrese solo letras';
        return null;
      },
      onSaved: (value) => vehicle.model = value,
    );
  }

  Widget _categoria() {
    return Row(
      children: <Widget>[
        // Agregar un icono.
        Text('Categoría de vehículo'),
        // Agregar un espacio.
        SizedBox(
          width: 30.0,
        ),
        // Expandir un elemento secundario que llene el espacio disponible de la fila.
        Expanded(
            // Establecer elemento que se debe expander.
            child: DropdownButton(
          value: _categoriaId,
          items: getItems(),
          onChanged: (value) {
            setState(() {
              _categoriaId = value;
            });
          },
        )),
      ],
    );
  }

  List<DropdownMenuItem<int>> getItems() {
    List<DropdownMenuItem<int>> items = new List();

    categoriasBloc.categorias.forEach((categoria) {
      items.add(
        DropdownMenuItem(
          child: Text(categoria.name),
          // Valor que contiene el item seleccionado del menu desplegable.
          value: categoria.id,
          onTap: () => vehicle.category = categoria,
        ),
      );
    });

    return items;
  }

  Widget _datoExtra() {
    //setState(() {});
    if (_categoriaId == 1) {
      return _txtCapacidadBateria();
    }
    if (_categoriaId == 2) {
      return _txtCapacidadCarga();
    }
    if (_categoriaId == 3) {
      return _txtCapacidadEspacio();
    }
    return SizedBox(
      height: 0.0,
    );
  }

  Widget _txtCapacidadBateria() {
    return TextFormField(
      initialValue: '${(vehicle?.extraValue ?? '')}',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Capacidad de batería'),
      validator: (value) {
        if (value.isEmpty) return 'Ingrese la capacidad';
        return null;
      },
      onSaved: (value) {
        vehicle.extra = 'Capacidad de batería';
        vehicle.extraValue = value;
      },
    );
  }

  Widget _txtCapacidadCarga() {
    return TextFormField(
      initialValue: '${(vehicle?.extraValue ?? '')}',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Capacidad de carga'),
      validator: (value) {
        if (value.isEmpty) return 'Ingrese la capacidad';
        return null;
      },
      onSaved: (value) {
        vehicle.extra = 'Capacidad máxima de carga';
        vehicle.extraValue = value;
      },
    );
  }

  Widget _txtCapacidadEspacio() {
    return TextFormField(
      initialValue: '${(vehicle?.extraValue ?? '')}',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Capacidad de espacio'),
      validator: (value) {
        if (value.isEmpty) return 'Ingrese la capacidad';
        return null;
      },
      onSaved: (value) {
        vehicle.extra = 'Capacidad de espacio';
        vehicle.extraValue = value;
      },
    );
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

    if (_categoriaId == 1) {
      // _showError('Selecciona una categoria');
      // return;
    }

    vehicle.categoryId = _categoriaId.toString();

    setState(() {
      _guardando = true;
    });

    print('TODO OK');
    print('Vehiculo    :${vehicle.model}');
    print('Precio      :${vehicle.price}');
    print('Nuevo       :${vehicle.used}');
    print('Categoria   :${vehicle.categoryId}');

    if (vehicle.id == null) {
      _showProgress(context, 'Guardando');
      if (_image != null) {
        vehicle.photoUrl = await bloc.subirFotoVehiculo(_image);
      }

      vehicle.createAt = DateTime.now().millisecondsSinceEpoch;
      bloc.agregarVehiculo(vehicle);
      _hideProgress(context);

      Navigator.pop(context);
    } else {
      if (vehicle.categoryId == '1') {
        _showError('Los vehículos eléctricos no se pueden editar');
        return;
      }

      _showProgress(context, 'Actualizando');
      if (_image != null) {
        vehicle.photoUrl = await bloc.subirFotoVehiculo(_image);
      }
      bloc.actualizarVehiculo(vehicle);

      _hideProgress(context);

      Navigator.pop(context);
    }
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
      //backgroundColor: Colors.teal,
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _showError(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _showProgress(BuildContext context, String titulo) {
    // Iniciar mostrar dialogo.
    showDialog(
        context: context,
        // Indica que el dialogo no se puede cerrar. Solo con acciones.
        barrierDismissible: false,
        // Construir.
        builder: (context) {
          // Devolver una nueva alerta de dialogo.
          return AlertDialog(
            // Poner un contorno de bordes redondos.
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('$titulo'),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 16.0),
                Text('Por favor espere...'),
              ],
            ),
          );
        });
  }

  void _hideProgress(BuildContext context) {
    Navigator.of(context).pop();
  }
}
