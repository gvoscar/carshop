import 'package:carshop/src/features/signin/events/signin_event.dart';

abstract class SigninProvider {
  Future<SigninEvent> checkUser(String email, String password);
}
