import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_auth.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_user.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/exceptions/auth_failure.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/repositories/i_auth_user_repository.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/usecase/auth_user_usecase.dart';

class AuthRepositoryMock extends Mock implements IAuthUseRepository {}

class CredentialAuthMock extends Mock implements CredentialAuth {}

class CredentialUserMock extends Mock implements CredentialUser {}

void main() {
  late AuthUseUsecaseImpl usecase;
  IAuthUseRepository repository = AuthRepositoryMock();
  CredentialAuthMock credentialAuth = CredentialAuthMock();
  CredentialUserMock credentialUser = CredentialUserMock();
  usecase = AuthUseUsecaseImpl(repository);

  setUp(() {});

  group(
    'AuthUserCase Tests >',
    () {
      group(
        'Register Success:',
        () {
          test('Should return Unit', (() async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');
            when(() => credentialAuth.password).thenReturn('2222222');

            when(() => repository.register(credentialAuth))
                .thenAnswer((_) async => const Right(unit));
            final result = await usecase.register(credentialAuth);

            expect(result.fold((l) => l, (r) => r), isA<Unit>());
          }));
        },
      );

      group(
        'Register Failure:',
        () {
          test('Should return Exception when email formact is incorrect',
              () async {
            when(() => credentialAuth.email).thenReturn('');
            when(() => credentialAuth.password).thenReturn('2222222');

            final result = await usecase.register(credentialAuth);

            expect(result.fold((l) => l, (r) => r), isA<InvalidEmail>());
          });

          test('Should return Exception when password is menor that 6',
              () async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');
            when(() => credentialAuth.password).thenReturn('');

            final result = await usecase.register(credentialAuth);

            expect(result.fold((l) => l, (r) => r), isA<PasswordLength>());
          });
        },
      );
    },
  );

  group(
    'AuthUserCase Tests >',
    () {
      group(
        'ResetPassword Success:',
        () {
          test('Should return Unit', (() async {
            when(() => repository.resetPasswords('emaivalido@mail.com'))
                .thenAnswer((_) async => const Right(unit));
            final result = await usecase.resetPasswords('emaivalido@mail.com');

            expect(result.fold((l) => l, (r) => r), isA<Unit>());
          }));
        },
      );

      group(
        'ResetPassword Failure:',
        () {
          test('Should return Exception when email formact is incorrect',
              () async {
            when(() => repository.resetPasswords('emailinvalido'))
                .thenThrow(InvalidEmail());

            final result = await usecase.resetPasswords('emailinvalido');

            expect(result.fold((l) => l, (r) => r), isA<InvalidEmail>());
          });
        },
      );
    },
  );

  group(
    'AuthUserCase Tests >',
    () {
      group(
        'LoginWithCredential Success:',
        () {
          test('Should return Unit', (() async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');
            when(() => credentialAuth.password).thenReturn('2222222');

            when(() => repository.signInWithEmailAndPassword(credentialAuth))
                .thenAnswer((_) async => Right(credentialUser));
            final result =
                await usecase.signInWithEmailAndPassword(credentialAuth);

            expect(result.fold((l) => l, (r) => r), isA<CredentialUser>());
          }));
        },
      );
      group(
        'LoginWithCredential Failure:',
        () {
          test('Should return Exception when email formact is incorrect',
              () async {
            when(() => credentialAuth.email).thenReturn('');

            final result =
                await usecase.signInWithEmailAndPassword(credentialAuth);

            expect(result.fold((l) => l, (r) => r), isA<InvalidEmail>());
          });

          test('Should return Exception when password is empty', () async {
            when(() => credentialAuth.email)
                .thenReturn('emailvalido@gmail.com');
            when(() => credentialAuth.password).thenReturn('');

            final result =
                await usecase.signInWithEmailAndPassword(credentialAuth);

            expect(result.fold((l) => l, (r) => r), isA<PasswordLength>());
          });
        },
      );
    },
  );

  group(
    'AuthUserCase Tests >',
    () {
      group(
        'SocialLogin  Success:',
        () {
          test('Should return Unit', (() async {
            when(() => repository.signInWithSocialLogin())
                .thenAnswer((_) async => Right(credentialUser));
            final result = await usecase.signInWithSocialLogin();

            expect(result.fold((l) => l, (r) => r), isA<CredentialUser>());
          }));
        },
      );
    },
  );
}
