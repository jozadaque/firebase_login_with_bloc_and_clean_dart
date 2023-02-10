import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_auth.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/exceptions/auth_failure.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/usecase/i_auth_user_usecase.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/register/register_auth_bloc.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/register/register_auth_event.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/register/register_auth_state.dart';

class AuthUserUsecaseMock extends Mock implements IAuthUserUsecase {}

class CredentialAuthMock extends Mock implements CredentialAuth {}

void main() {
  late AuthUserUsecaseMock usecase;
  late CredentialAuthMock credential;

  setUp(
    () {
      usecase = AuthUserUsecaseMock();
      credential = CredentialAuthMock();
    },
  );

  group(
    'RegisterBloc Tests >',
    () {
      group(
        'Success:',
        () {
          blocTest<RegisterAuthBloc, RegisterAuthState>(
            'Should return a Loading and Success States',
            build: () {
              when(() => credential.email).thenReturn('emailvalido@gmail.com');
              when(() => credential.password).thenReturn('2222222');

              when(() => usecase.register(credential))
                  .thenAnswer((_) async => const Right(unit));

              return RegisterAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(CreateUserEvent(credential)),
            expect: () => [
              isA<LoadingRegisterAuthState>(),
              isA<SuccessRegisterAuthSate>(),
            ],
          );

          blocTest<RegisterAuthBloc, RegisterAuthState>(
            'Should return a Loading and Inicial States',
            build: () {
              return RegisterAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(InitialRegisterAuthEvent()),
            expect: () => [
              isA<LoadingRegisterAuthState>(),
              isA<InitialRegisterAuthState>(),
            ],
          );
        },
      );
      group(
        'Failure:',
        () {
          blocTest<RegisterAuthBloc, RegisterAuthState>(
            'Should return a Loading and Exception State to invalid email',
            build: () {
              when(() => credential.email).thenReturn('emailvalido@gmail.com');
              when(() => credential.password).thenReturn('2222222');

              when(() => usecase.register(credential))
                  .thenAnswer((_) async => Left(InvalidEmail()));

              return RegisterAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(CreateUserEvent(credential)),
            expect: () => [
              isA<LoadingRegisterAuthState>(),
              isA<ExceptionRegisterAuthState>(),
            ],
          );

          blocTest<RegisterAuthBloc, RegisterAuthState>(
            'Should return a Loading and Exception State to invalid password',
            build: () {
              when(() => credential.email).thenReturn('emailvalido@gmail.com');
              when(() => credential.password).thenReturn('2222222');

              when(() => usecase.register(credential))
                  .thenAnswer((_) async => Left(PasswordLength()));

              return RegisterAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(CreateUserEvent(credential)),
            expect: () => [
              isA<LoadingRegisterAuthState>(),
              isA<ExceptionRegisterAuthState>(),
            ],
          );
        },
      );
    },
  );
}
