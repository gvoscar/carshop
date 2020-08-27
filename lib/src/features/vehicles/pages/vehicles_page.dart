import 'package:carshop/src/features/vehicles/blocs/vehicles_bloc.dart';
import 'package:carshop/src/models/vehicle.dart';
import 'package:carshop/src/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SessionProvider>(context).vehiclesBloc;
    bloc.cargarVehiculos();

    return Scaffold(
      body: _crearLista(bloc),
    );
  }

  Widget _crearLista(VehiclesBloc bloc) {
    return StreamBuilder(
      stream: bloc.vehiculosStream,
      builder: (BuildContext context, AsyncSnapshot<List<Vehicle>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Container(
              child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) => _crearItem(context, bloc, data[i]),
          ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(
      BuildContext context, VehiclesBloc productosBloc, Vehicle vehicle) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          // Borrar vehiculo
          // bloc.borrarVehiculo(vehicle.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              (vehicle.photoUrl == null)
                  ? Image(image: AssetImage('assets/no-imagen.png'))
                  : FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'),
                      image: NetworkImage(vehicle.photoUrl),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${vehicle.model} | \$${vehicle.price}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${(vehicle.used == 0) ? 'Vehículo nuevo' : 'Vehículo usado'}'),
                    Text('Asientos: ${vehicle.occupants}')
                  ],
                ),
                onTap: () =>
                    Navigator.pushNamed(context, 'vehicle', arguments: vehicle),
              ),
            ],
          ),
        ));
  }
}
