import 'dart:io';

import 'package:carshop/src/features/vehicles/providers/vehicles_provider.dart';
import 'package:carshop/src/features/vehicles/providers/vehicles_provider_impl.dart';
import 'package:carshop/src/models/vehicle.dart';
import 'package:rxdart/rxdart.dart';

class VehiclesBloc {
  final VehiclesProvider _provider = new VehiclesProviderImpl();
  final _vehiculosController = new BehaviorSubject<List<Vehicle>>();
  final _cargaController = new BehaviorSubject<bool>();

  Stream<List<Vehicle>> get vehiculosStream => _vehiculosController.stream;
  Stream<bool> get cargaStream => _cargaController.stream;

  void cargarVehiculos() async {
    final data = await _provider.cargarVehiculos();
    _vehiculosController.sink.add(data);
  }

  void agregarVehiculo(Vehicle vehicle) async {
    _cargaController.sink.add(true);
    await _provider.agregarVehiculo(vehicle);
    _cargaController.sink.add(false);
    cargarVehiculos();
  }

  void actualizarVehiculo(Vehicle vehicle) async {
    _cargaController.sink.add(true);
    await _provider.actualizarVehiculo(vehicle);
    _cargaController.sink.add(false);
    cargarVehiculos();
  }

  Future<String> subirFotoVehiculo(File foto) async {
    _cargaController.sink.add(true);
    final fotoURL = await _provider.subirFoto(foto);
    _cargaController.sink.add(false);
    return fotoURL;
  }

  dispose() {
    _vehiculosController?.close();
    _cargaController?.close();
  }
}
