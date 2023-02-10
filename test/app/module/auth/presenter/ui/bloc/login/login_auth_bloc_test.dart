import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_auth.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_user.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/exceptions/auth_failure.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/usecase/i_auth_user_usecase.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/login/login_auth_bloc.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/login/login_auth_event.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/login/login_auth_state.dart';

class AuthUserUsecaseMock extends Mock implements IAuthUserUsecase {}

class CredentialAuthMock extends Mock implements CredentialAuth {}

void main() {
  late AuthUserUsecaseMock usecase;
  late CredentialAuthMock credentialAuth;

  setUp(
    () {
      usecase = AuthUserUsecaseMock();
      credentialAuth = CredentialAuthMock();
    },
  );

  group(
    'LoginBloc Tests >',
    () {
      group(
        'Success:',
        () {
          blocTest<LoginAuthBloc, LoginAuthState>(
            'Should return a Loading and Success States',
            build: () {
              when(() => credentialAuth.email)
                  .thenReturn('emailvalido@gmail.com');
              when(() => credentialAuth.password).thenReturn('2222222');

              when(() => usecase.signInWithEmailAndPassword(credentialAuth))
                  .thenAnswer((_) async => const Right(CredentialUser(
                      email: 'email@email.com', uuid: 'kkfdllojkrel')));

              return LoginAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(LoginUserEvent(credentialAuth)),
            expect: () => [
              isA<LoadingLoginAuthState>(),
              isA<SuccessLoginAuthSate>(),
            ],
          );

          blocTest<LoginAuthBloc, LoginAuthState>(
            'Should return a Loading and Success Social Login States',
            build: () {
              when(() => usecase.signInWithSocialLogin()).thenAnswer(
                  (_) async => const Right(CredentialUser(
                      email: 'email@email.com', uuid: 'kkfdllojkrel')));

              return LoginAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(SocialLoginUserEvent()),
            expect: () => [
              isA<LoadingLoginAuthState>(),
              isA<SuccessLoginAuthSate>(),
            ],
          );

          blocTest<LoginAuthBloc, LoginAuthState>(
            'Should return a Loading and Inicial States',
            build: () {
              return LoginAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(InitialLoginAuthEvent()),
            expect: () => [
              isA<LoadingLoginAuthState>(),
              isA<InitialLoginAuthState>(),
            ],
          );
        },
      );
      group(
        'Failure:',
        () {
          blocTest<LoginAuthBloc, LoginAuthState>(
            'Should return a Loading and Exception State to invalid email',
            build: () {
              when(() => credentialAuth.email)
                  .thenReturn('emailvalido@gmail.com');
              when(() => credentialAuth.password).thenReturn('2222222');

              when(() => usecase.signInWithEmailAndPassword(credentialAuth))
                  .thenAnswer((_) async => Left(InvalidEmail()));

              return LoginAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(LoginUserEvent(credentialAuth)),
            expect: () => [
              isA<LoadingLoginAuthState>(),
              isA<ExceptionLoginAuthState>(),
            ],
          );

          blocTest<LoginAuthBloc, LoginAuthState>(
            'Should return a Loading and Exception State to invalid password',
            build: () {
              when(() => credentialAuth.email)
                  .thenReturn('emailvalido@gmail.com');
              when(() => credentialAuth.password).thenReturn('2222222');

              when(() => usecase.signInWithEmailAndPassword(credentialAuth))
                  .thenAnswer((_) async => Left(PasswordLength()));

              return LoginAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(LoginUserEvent(credentialAuth)),
            expect: () => [
              isA<LoadingLoginAuthState>(),
              isA<ExceptionLoginAuthState>(),
            ],
          );

          blocTest<LoginAuthBloc, LoginAuthState>(
            'Should return a Loading and Exception to  Social Login',
            build: () {
              when(() => usecase.signInWithSocialLogin()).thenAnswer(
                  (_) async => Left(RepositorySocialLoginException()));
              return LoginAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(SocialLoginUserEvent()),
            expect: () => [
              isA<LoadingLoginAuthState>(),
              isA<ExceptionLoginAuthState>(),
            ],
          );
        },
      );
    },
  );
}
