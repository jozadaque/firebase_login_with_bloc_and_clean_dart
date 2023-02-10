import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_auth.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_user.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/exceptions/auth_failure.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/infra/datasources/i_auth_user_datasource.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/infra/repositories/auth_user_repository_impl.dart';

class AuthDatasourceMock extends Mock implements IAuthUserDatasource {}

class CredentialMock extends Mock implements CredentialAuth {}

void main() {
  IAuthUserDatasource datasource = AuthDatasourceMock();
  CredentialAuth credential = CredentialMock();
  late AuthUseRepositoryImpl repository;

  setUp(() {
    repository = AuthUseRepositoryImpl(datasource);
  });

  group(
    'AuthRepository Tests >',
    () {
      group(
        'Register Success:',
        () {
          test('Should return a Unit', () async {
            when(() => datasource.register(credential))
                .thenAnswer((_) async => unit);

            final result = await repository.register(credential);

            expect(result.fold((l) => l, (r) => r), isA<Unit>());
          });
        },
      );
      group(
        'Register Failure:',
        () {
          test('Should return a RepositoryAuthException', () async {
            when(() => datasource.register(credential))
                .thenThrow(RepositoryRegisterAuthException());

            final result = await repository.register(credential);

            expect(result.fold((l) => l, (r) => r),
                isA<RepositoryRegisterAuthException>());
          });
        },
      );
    },
  );

  group(
    'AuthRepository Tests >',
    () {
      group(
        'ResetPassword Success:',
        () {
          test('Should return a Unit', () async {
            when(() => datasource.resetPasswords('emailvalido@mail.com'))
                .thenAnswer((_) async => unit);

            final result =
                await repository.resetPasswords('emailvalido@mail.com');

            expect(result.fold((l) => l, (r) => r), isA<Unit>());
          });
        },
      );
      group(
        'ResetPassword Failure:',
        () {
          test('Should return a RepositoryAuthException', () async {
            when(() => datasource.resetPasswords('emailinvalido'))
                .thenThrow(RepositoryResetPasswordAuthException());

            final result = await repository.resetPasswords('emailinvalido');

            expect(result.fold((l) => l, (r) => r),
                isA<RepositoryResetPasswordAuthException>());
          });
        },
      );
    },
  );

  group(
    'AuthRepository Tests >',
    () {
      group(
        'Login Credencial Success:',
        () {
          test('Should return a CredentialUser', () async {
            when(() => datasource.signInWithEmailAndPassword(credential))
                .thenAnswer((_) async => const CredentialUser(
                    email: 'email@email.com', uuid: 'uuideweweweqeqeasda'));

            final result =
                await repository.signInWithEmailAndPassword(credential);

            expect(result.fold((l) => l, (r) => r), isA<CredentialUser>());
          });
        },
      );
      group(
        'Login Credencial  Failure:',
        () {
          test(
              'Should return a RepositorySignWithLoginAndPasswordAuthException',
              () async {
            when(() => datasource.signInWithEmailAndPassword(credential))
                .thenThrow(RepositorySignWithLoginAndPasswordAuthException());

            final result =
                await repository.signInWithEmailAndPassword(credential);

            expect(result.fold((l) => l, (r) => r),
                isA<RepositorySignWithLoginAndPasswordAuthException>());
          });
        },
      );
    },
  );

  group(
    'AuthRepository Tests >',
    () {
      group(
        'Social Login Success:',
        () {
          test('Should return a CredentialUser', () async {
            when(() => datasource.signInWithSocialLogin()).thenAnswer(
                (_) async => const CredentialUser(
                    email: 'email@email.com', uuid: 'uuideweweweqeqeasda'));

            final result = await repository.signInWithSocialLogin();

            expect(result.fold((l) => l, (r) => r), isA<CredentialUser>());
          });
        },
      );
      group(
        'Social Login Failure:',
        () {
          test('Should return a RepositorySocialLoginException', () async {
            when(() => datasource.signInWithSocialLogin())
                .thenThrow(RepositorySocialLoginException());

            final result = await repository.signInWithSocialLogin();

            expect(result.fold((l) => l, (r) => r),
                isA<RepositorySocialLoginException>());
          });
        },
      );
    },
  );
}
