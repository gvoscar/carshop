import 'package:carshop/src/features/categories/blocs/categories_bloc.dart';
import 'package:carshop/src/features/signin/bloc/signin_bloc.dart';
import 'package:carshop/src/features/signup/blocs/signup_bloc.dart';
import 'package:carshop/src/features/vehicles/blocs/vehicles_bloc.dart';
import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  final _signinBloc = new SigninBloc();
  final _signupBloc = new SignupBloc();
  final _categoriesBloc = new CategoriesBloc();
  final _vehiclesBloc = new VehiclesBloc();

  SigninBloc get signinBloc => _signinBloc;
  SignupBloc get signupBloc => _signupBloc;
  CategoriesBloc get categoriesBloc => _categoriesBloc;
  VehiclesBloc get vehiclesBloc => _vehiclesBloc;
}
