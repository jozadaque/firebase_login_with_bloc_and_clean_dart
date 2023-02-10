abstract class IFailureAuth {
  final String? message;

  IFailureAuth([this.message]);
}

class InvalidEmail implements IFailureAuth {
  @override
  final String? message;

  InvalidEmail([this.message = 'E-mail inválido.']);
}

class PasswordLength implements IFailureAuth {
  @override
  final String? message;

  PasswordLength([this.message = 'Senha Invalida.']);
}

class RepositoryRegisterAuthException implements IFailureAuth {
  @override
  final String? message;

  RepositoryRegisterAuthException(
      [this.message =
          'RepositoryAuthRegisterException: Falha ao solicitar cadastro.']);
}

class RepositoryResetPasswordAuthException implements IFailureAuth {
  @override
  final String? message;

  RepositoryResetPasswordAuthException(
      [this.message =
          'RepositoryAuthResetPasswordException: Falha ao solicitar reset de senha.']);
}

class RepositorySignWithLoginAndPasswordAuthException implements IFailureAuth {
  @override
  final String? message;

  RepositorySignWithLoginAndPasswordAuthException(
      [this.message =
          'RepositorySignWithLoginAndPasswordAuthException: Falha ao solicitar login.']);
}

class RepositorySocialLoginException implements IFailureAuth {
  @override
  final String? message;

  RepositorySocialLoginException(
      [this.message =
          'RepositorySocialLoginException: Falha ao solicitar login.']);
}

class RegisterAuthException implements IFailureAuth {
  @override
  final String? message;

  RegisterAuthException([this.message]);
}

class DatasourceRegisterAuthException implements IFailureAuth {
  @override
  final String? message;

  DatasourceRegisterAuthException(
      [this.message =
          'AuthUserDatasourceRegisterException: Falha ao solicitar cadastro.']);
}

class DatasourceResetPasswordAuthException implements IFailureAuth {
  @override
  final String? message;

  DatasourceResetPasswordAuthException(
      [this.message =
          'AuthUserDatasourceResetPasswordException: Falha ao solicitar reset de senha.']);
}

class DatasourceLoginInWithEmailAndPasswordAuthException
    implements IFailureAuth {
  @override
  final String? message;

  DatasourceLoginInWithEmailAndPasswordAuthException(
      [this.message =
          'DatasourceLoginInWithEmailAndPasswordAuthException: Falha ao solicitar login.']);
}

class DatasourceSocialLoginAuthException implements IFailureAuth {
  @override
  final String? message;

  DatasourceSocialLoginAuthException(
      [this.message =
          'DatasourceSocialLoginAuthException: Falha ao solicitar login.']);
}
