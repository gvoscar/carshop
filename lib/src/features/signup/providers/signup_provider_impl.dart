import 'package:carshop/src/database/database.dart';
import 'package:carshop/src/features/signup/events/signup_event.dart';
import 'package:carshop/src/features/signup/providers/signup_provider.dart';
import 'package:carshop/src/models/user.dart';

class SignupProviderImpl implements SignupProvider {
  SignupProviderImpl();
  @override
  Future<SignupEvent> createUser(String email, String password) async {
    final user = await DB.db.consultarUsuario(email);

    if (user != null) {
      print('El usuario ya se encuentra registrado');
      return SignupEvent(
          eventType: SignupEvent.ERROR,
          message: 'El usuario ya se encuentra registrado');
    }

    final newUser = new User(email: email, password: password);
    await DB.db.crearUsuario(newUser);

    return SignupEvent(
        eventType: SignupEvent.SUCCESS,
        message: 'Usuario creado',
        user: newUser);
  }
}
