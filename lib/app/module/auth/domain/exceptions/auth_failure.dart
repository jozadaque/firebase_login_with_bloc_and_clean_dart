abstract class IFailureAuth {
  final String? message;

  IFailureAuth([this.message]);
}

class InvalidEmail implements IFailureAuth {
  @override
  final String? message;

  InvalidEmail([this.message = 'Invalid Email.']);
}

class PasswordLength implements IFailureAuth {
  @override
  final String? message;

  PasswordLength([this.message = 'Invalid password.']);
}

class RepositoryRegisterAuthException implements IFailureAuth {
  @override
  final String? message;

  RepositoryRegisterAuthException(
      [this.message =
          'RepositoryAuthRegisterException: Failed to request registration.']);
}

class RepositoryResetPasswordAuthException implements IFailureAuth {
  @override
  final String? message;

  RepositoryResetPasswordAuthException(
      [this.message =
          'RepositoryAuthResetPasswordException: Failed to request password reset.']);
}

class RepositorySignWithLoginAndPasswordAuthException implements IFailureAuth {
  @override
  final String? message;

  RepositorySignWithLoginAndPasswordAuthException(
      [this.message =
          'RepositorySignWithLoginAndPasswordAuthException: Failed to request login.']);
}

class RepositorySocialLoginException implements IFailureAuth {
  @override
  final String? message;

  RepositorySocialLoginException(
      [this.message =
          'RepositorySocialLoginException: Failed to request login.']);
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
          'AuthUserDatasourceRegisterException: Failed to request registration.']);
}

class DatasourceResetPasswordAuthException implements IFailureAuth {
  @override
  final String? message;

  DatasourceResetPasswordAuthException(
      [this.message =
          'AuthUserDatasourceResetPasswordException: Failed to request password reset.']);
}

class DatasourceLoginInWithEmailAndPasswordAuthException
    implements IFailureAuth {
  @override
  final String? message;

  DatasourceLoginInWithEmailAndPasswordAuthException(
      [this.message =
          'DatasourceLoginInWithEmailAndPasswordAuthException: Failed to request login.']);
}

class DatasourceSocialLoginAuthException implements IFailureAuth {
  @override
  final String? message;

  DatasourceSocialLoginAuthException(
      [this.message =
          'DatasourceSocialLoginAuthException: Failed to request login.']);
}
