import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../private/guard.dart';
import 'domain/repositories/i_auth_user_repository.dart';
import 'domain/usecase/auth_user_usecase.dart';
import 'domain/usecase/i_auth_user_usecase.dart';
import 'external/datasources/auth_user_datasource.dart';
import 'external/driver/firebase_auth.dart';
import 'infra/datasources/i_auth_user_datasource.dart';
import 'infra/repositories/auth_user_repository_impl.dart';
import 'presenter/ui/bloc/login/login_auth_bloc.dart';
import 'presenter/ui/bloc/register/register_auth_bloc.dart';
import 'presenter/ui/bloc/reset_password/reset_password_auth_bloc.dart';
import 'presenter/ui/pages/login_page.dart';
import 'presenter/ui/pages/register_page.dart';
import 'presenter/ui/pages/reset_password_page.dart';
import '../private/home_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => FirebaseAuth.instance),
    Bind.factory((i) => FireBaseAuthService((i)())),
    Bind.factory<IAuthUserDatasource>((i) => AuthUserDatasourceImpl((i)())),
    Bind.factory<IAuthUseRepository>((i) => AuthUseRepositoryImpl((i)())),
    Bind.factory<IAuthUserUsecase>((i) => AuthUseUsecaseImpl((i)())),
    Bind.singleton((i) => RegisterAuthBloc((i)())),
    Bind.singleton((i) => ResetPasswordAuthBloc((i)())),
    Bind.singleton((i) => LoginAuthBloc((i)())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, args) => LoginPage(
              message: args.data,
            )),
    ChildRoute('/register-page',
        child: (context, args) => const RegisterPage()),
    ChildRoute('/reset-password-page',
        child: (context, args) => const ResetPasswordPage()),
    ChildRoute('/private/home-page',
        child: (context, args) => const HomePage(), guards: [AuthGuard()]),
  ];
}
