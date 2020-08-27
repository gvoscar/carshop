import 'package:carshop/src/models/user.dart';
import 'package:flutter/material.dart';

class SignupEvent {
  static const int ERROR = 101;
  static const int SUCCESS = 200;

  int eventType;
  String message;
  User user;

  SignupEvent({@required this.eventType, this.message, this.user});

  @override
  String toString() {
    return 'EVENT: $eventType, MESSAGE: $message';
  }
}
