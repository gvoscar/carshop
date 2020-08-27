import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:carshop/src/database/database.dart';
import 'package:carshop/src/features/vehicles/providers/vehicles_provider.dart';
import 'package:carshop/src/models/vehicle.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class VehiclesProviderImpl implements VehiclesProvider {
  VehiclesProviderImpl();

  @override
  Future<Vehicle> actualizarVehiculo(Vehicle vehicle) async {
    await DB.db.actualizarVehiculo(vehicle);
    return vehicle;
  }

  @override
  Future<Vehicle> agregarVehiculo(Vehicle vehicle) async {
    final data = await DB.db.crearVehiculo(vehicle);
    vehicle.id = data;
    return vehicle;
  }

  @override
  Future<List<Vehicle>> cargarVehiculos() async {
    final data = await DB.db.consultarVehiculos();
    return data;
  }

  @override
  Future<String> subirFoto(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/donyebp8c/image/upload?upload_preset=lttqnnmv');
    final mimeType = mime(imagen.path).split('/'); //ejemplo: imagen/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print('${resp.body}');
      return null;
    }

    final respData = json.decode(resp.body);

    print(respData);

    return respData['secure_url'];
  }
}
