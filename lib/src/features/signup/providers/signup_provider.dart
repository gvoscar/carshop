import 'package:carshop/src/features/signup/events/signup_event.dart';

abstract class SignupProvider {
  Future<SignupEvent> createUser(String email, String password);
}
