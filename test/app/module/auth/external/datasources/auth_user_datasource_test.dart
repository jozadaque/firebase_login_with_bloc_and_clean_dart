import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_auth.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_user.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/exceptions/auth_failure.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/external/datasources/auth_user_datasource.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/external/driver/firebase_auth.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/infra/datasources/i_auth_user_datasource.dart';

class FireBaseAuthServiceMock extends Mock implements FireBaseAuthService {}

class CredentialAuthMock extends Mock implements CredentialAuth {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

CredentialUser credentialUser =
    const CredentialUser(email: 'email@email.com', uuid: 'hfdhfjskdhfsuh');

void main() {
  late IAuthUserDatasource datasource;
  FireBaseAuthServiceMock service = FireBaseAuthServiceMock();
  CredentialAuthMock credentialAuth = CredentialAuthMock();

  setUp(() {
    datasource = AuthUserDatasourceImpl(service);
  });

  group(
    'AuthDatasource Tests >',
    () {
      group(
        'Register Success:',
        () {
          test('Should return a Unit', () async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');
            when(() => credentialAuth.password).thenReturn('2222222');

            when(() => service.registerWithEmailAndPassword(credentialAuth))
                .thenAnswer((_) async => true);

            final result = await datasource.register(credentialAuth);

            expect(result, unit);
          });
        },
      );
      group(
        'Register Failure:',
        () {
          test('Should return a AuthUserDatasourceException', () async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');

            when(() => service.registerWithEmailAndPassword(credentialAuth))
                .thenAnswer((_) async => false);

            expect(() async {
              return await datasource.register(credentialAuth);
            }, throwsA(isA<DatasourceRegisterAuthException>()));
          });
        },
      );
    },
  );

  group(
    'AuthDatasource Tests >',
    () {
      group(
        'ResetPassword Success:',
        () {
          test('Should return a Unit', () async {
            when(() => service.resetPassword('emailvalido@mail.com'))
                .thenAnswer((_) async => true);

            final result =
                await datasource.resetPasswords('emailvalido@mail.com');

            expect(result, unit);
          });
        },
      );
      group(
        'ResetPassword Failure:',
        () {
          test('Should return a DatasourceResetPasswordAuthException',
              () async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');

            when(() => service.resetPassword('credentialAuth'))
                .thenAnswer((_) async => false);

            expect(() async {
              return await datasource.resetPasswords('credentialAuth');
            }, throwsA(isA<DatasourceResetPasswordAuthException>()));
          });
        },
      );
    },
  );

  group(
    'AuthDatasource Tests >',
    () {
      group(
        'Login Credencial Success:',
        () {
          test('Should return a Credencial User', () async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');
            when(() => credentialAuth.password).thenReturn('2222222');

            when(() => service.signInWithEmailAndPassword(credentialAuth))
                .thenAnswer((_) async => credentialUser);

            final result =
                await datasource.signInWithEmailAndPassword(credentialAuth);

            expect(result, isA<CredentialUser>());
          });
        },
      );
      group(
        'Login Credencial Failure:',
        () {
          test('Should return a AuthUserDatasourceException', () async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');
            when(() => service.signInWithEmailAndPassword(credentialAuth))
                .thenThrow(
                    DatasourceLoginInWithEmailAndPasswordAuthException());

            expect(() async {
              return await datasource
                  .signInWithEmailAndPassword(credentialAuth);
            },
                throwsA(
                    isA<DatasourceLoginInWithEmailAndPasswordAuthException>()));
          });

          test(
              'Should return a AuthUserDatasourceException when e-mail is empty.',
              () async {
            when(() => credentialAuth.email).thenThrow(
                DatasourceLoginInWithEmailAndPasswordAuthException());
            when(() => service.signInWithEmailAndPassword(credentialAuth))
                .thenAnswer((_) async =>
                    const CredentialUser(email: 'email@email.com', uuid: ''));

            expect(() async {
              return await datasource
                  .signInWithEmailAndPassword(credentialAuth);
            },
                throwsA(
                    isA<DatasourceLoginInWithEmailAndPasswordAuthException>()));
          });
        },
      );
    },
  );

  group(
    'AuthDatasource Tests >',
    () {
      group(
        'Social Login Success:',
        () {
          test('Should return a Credencial User', () async {
            when(() => service.socialLogin())
                .thenAnswer((_) async => credentialUser);

            final result = await datasource.signInWithSocialLogin();

            expect(result, isA<CredentialUser>());
          });
        },
      );
      group(
        'Social Login Failure:',
        () {
          test(
              'Should return a AuthUserDatasourceException when e-mail is empty.',
              () async {
            when(() => service.socialLogin()).thenAnswer((_) async =>
                const CredentialUser(email: 'email@email.com', uuid: ''));

            expect(() async {
              return await datasource.signInWithSocialLogin();
            }, throwsA(isA<DatasourceSocialLoginAuthException>()));
          });
        },
      );
    },
  );
}
