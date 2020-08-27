import 'package:carshop/src/features/signin/bloc/signin_bloc.dart';
import 'package:carshop/src/features/signup/blocs/signup_bloc.dart';
import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  final _signinBloc = new SigninBloc();
  final _signupBloc = new SignupBloc();

  get signinBloc => _signinBloc;
  get signupBloc => _signupBloc;
}
