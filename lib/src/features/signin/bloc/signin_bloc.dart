import 'package:carshop/src/features/signin/events/signin_event.dart';
import 'package:carshop/src/features/signin/providers/signin_provider.dart';
import 'package:carshop/src/features/signin/providers/signin_provider_impl.dart';
import 'package:carshop/src/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

/// Bloc para validar formulario de inicio de sesión
class SigninBloc with Validators {
  final SigninProvider _provider = SigninProviderImpl();
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

  Future<SigninEvent> signin(String email, String password) =>
      _provider.checkUser(email, password);
}
