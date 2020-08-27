import 'package:carshop/src/features/categories/blocs/categories_bloc.dart';
import 'package:carshop/src/models/category.dart';
import 'package:carshop/src/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SessionProvider>(context).categoriesBloc;
    bloc.cargarCategorias();

    return Scaffold(
      body: _crearListaCategorias(bloc),
    );
  }

  Widget _crearListaCategorias(CategoriesBloc bloc) {
    print('_crearListadoProductos');
    return StreamBuilder(
      stream: bloc.categoriasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return Container(
              child: ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) =>
                _crearItem(context, bloc, productos[i]),
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
      BuildContext context, CategoriesBloc productosBloc, Category category) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          // Borrar producto
          // bloc.borrarCategoria(category.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('${category.name}'),
                subtitle: Text('${category.id}'),
                onTap: () => Navigator.pushNamed(context, 'category',
                    arguments: category),
              ),
            ],
          ),
        ));
  }
}
