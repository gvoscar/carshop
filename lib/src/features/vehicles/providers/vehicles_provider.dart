import 'dart:io';

import 'package:carshop/src/models/vehicle.dart';

abstract class VehiclesProvider {
  Future<List<Vehicle>> cargarVehiculos();
  Future<Vehicle> agregarVehiculo(Vehicle vehicle);
  Future<Vehicle> actualizarVehiculo(Vehicle vehicle);
  Future<String> subirFoto(File imagen);
}
