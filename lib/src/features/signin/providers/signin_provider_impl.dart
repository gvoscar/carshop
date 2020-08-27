import 'package:carshop/src/database/database.dart';
import 'package:carshop/src/features/signin/events/signin_event.dart';
import 'package:carshop/src/features/signin/providers/signin_provider.dart';

class SigninProviderImpl implements SigninProvider {
  SigninProviderImpl() {}

  @override
  Future<SigninEvent> checkUser(String email, String password) async {
    final user = await DB.db.consultarUsuario(email);
    if (user == null)
      return SigninEvent(
          eventType: SigninEvent.ERROR, message: 'Usuario no registrado');

    if (user.password != password)
      return SigninEvent(
          eventType: SigninEvent.ERROR,
          message: 'Usuario y contraseña no validos');

    return SigninEvent(
        eventType: SigninEvent.SUCCESS,
        message: 'Usuario autenticado',
        user: user);
  }
}
