import 'package:carshop/src/features/signup/events/signup_event.dart';
import 'package:carshop/src/features/signup/providers/signup_provider.dart';
import 'package:carshop/src/features/signup/providers/signup_provider_impl.dart';
import 'package:carshop/src/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

/// Bloc para validar formulario de inicio de sesión
class SignupBloc with Validators {
  final SignupProvider _provider = new SignupProviderImpl();
  final _switchController = BehaviorSubject<bool>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<bool> get themeStream => _switchController.stream;
  // Stream de email.
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  // Stream de password.
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  /// Resultado de validacion de email y password.
  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(bool) get themeChange => _switchController.sink.add;
  // Agregar valores a Stream de email.
  Function(String) get changeEmail => _emailController.sink.add;
  // Agregar valores a Stream de password.
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el último valor ingresado a los streams
  bool get theme => _switchController.value ?? false;
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _switchController?.close();
    _emailController?.close();
    _passwordController?.close();
  }

  Future<SignupEvent> signup(String email, String password) =>
      _provider.createUser(email, password);
}
