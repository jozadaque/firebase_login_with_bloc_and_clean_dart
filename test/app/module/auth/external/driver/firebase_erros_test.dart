import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth//external/driver/firebase_erros.dart';

void main() {
  group(
    'FirebaseErros Test >',
    () {
      test(
        'Should return "E-mail já cadastrado" when code error is email-already-exists',
        () {
          when(
            () => FirebaseErrors.convertMessageError('email-already-exists'),
          );

          final result =
              FirebaseErrors.convertMessageError('email-already-exists');

          expect(result, 'E-mail já Cadastrado');
        },
      );

      test(
        'Should return "E-mail inválido" when code error is invalid-email',
        () {
          when(
            () => FirebaseErrors.convertMessageError('invalid-email'),
          );

          final result = FirebaseErrors.convertMessageError('invalid-email');

          expect(result, 'E-mail inválido');
        },
      );

      test(
        'Should return "Senha Inválida" when code error is invalid-password',
        () {
          when(
            () => FirebaseErrors.convertMessageError('invalid-password'),
          );

          final result = FirebaseErrors.convertMessageError('invalid-password');

          expect(result, 'Senha inválida');
        },
      );

      test(
        'Should return "E-mail já esta em uso" when code error is email-already-in-use',
        () {
          when(
            () => FirebaseErrors.convertMessageError('email-already-in-use'),
          );

          final result =
              FirebaseErrors.convertMessageError('email-already-in-use');

          expect(result, 'E-mail já esta em uso');
        },
      );
    },
  );
}
