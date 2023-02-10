import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/entities/credential_auth.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/exceptions/auth_failure.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/domain/usecase/i_auth_user_usecase.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/reset_password/reset_password_auth_bloc.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/reset_password/reset_password_auth_event.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/bloc/reset_password/reset_password_auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthUserUsecaseMock extends Mock implements IAuthUserUsecase {}

class CredentialAuthMock extends Mock implements CredentialAuth {}

void main() {
  late AuthUserUsecaseMock usecase;

  setUp(
    () {
      usecase = AuthUserUsecaseMock();
    },
  );

  group(
    'ResetPasswordBloc Tests >',
    () {
      group(
        'Success:',
        () {
          blocTest<ResetPasswordAuthBloc, ResetPasswordAuthState>(
            'Should return a Loading and Success States',
            build: () {
              when(() => usecase.resetPasswords('emailvalido@gmail.com'))
                  .thenAnswer((_) async => const Right(unit));

              return ResetPasswordAuthBloc(usecase);
            },
            act: (bloc) =>
                bloc.add(ResetPasswordEvent('emailvalido@gmail.com')),
            expect: () => [
              isA<LoadingResetPasswordAuthState>(),
              isA<SuccessResetPasswordAuthSate>(),
            ],
          );

          blocTest<ResetPasswordAuthBloc, ResetPasswordAuthState>(
            'Should return a Loading and Inicial States',
            build: () {
              return ResetPasswordAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(InitialResetPasswordAuthEvent()),
            expect: () => [
              isA<LoadingResetPasswordAuthState>(),
              isA<InitialResetPasswordAuthState>(),
            ],
          );
        },
      );
      group(
        'Failure:',
        () {
          blocTest<ResetPasswordAuthBloc, ResetPasswordAuthState>(
            'Should return a Loading and Exception State to invalid email',
            build: () {
              when(() => usecase.resetPasswords('emailvalidogmail.com'))
                  .thenAnswer((_) async => Left(InvalidEmail()));

              return ResetPasswordAuthBloc(usecase);
            },
            act: (bloc) => bloc.add(ResetPasswordEvent('emailvalidogmail.com')),
            expect: () => [
              isA<LoadingResetPasswordAuthState>(),
              isA<ExceptionResetPasswordAuthState>(),
            ],
          );
        },
      );
    },
  );
}
