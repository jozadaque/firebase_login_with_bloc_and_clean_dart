import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth//external/driver/firebase_erros.dart';

void main() {
  group(
    'FirebaseErros Test >',
    () {
      test(
        'Should return "Email already exists" when code error is email-already-exists',
        () {
          when(
            () => FirebaseErrors.convertMessageError('email-already-exists'),
          );

          final result =
              FirebaseErrors.convertMessageError('email-already-exists');

          expect(result, 'Email already exists');
        },
      );

      test(
        'Should return "Invalid Email" when code error is invalid-email',
        () {
          when(
            () => FirebaseErrors.convertMessageError('invalid-email'),
          );

          final result = FirebaseErrors.convertMessageError('invalid-email');

          expect(result, 'Invalid Email');
        },
      );

      test(
        'Should return "Invalid password" when code error is invalid-password',
        () {
          when(
            () => FirebaseErrors.convertMessageError('invalid-password'),
          );

          final result = FirebaseErrors.convertMessageError('invalid-password');

          expect(result, 'Invalid password');
        },
      );

      test(
        'Should return "Email already in use" when code error is email-already-in-use',
        () {
          when(
            () => FirebaseErrors.convertMessageError('email-already-in-use'),
          );

          final result =
              FirebaseErrors.convertMessageError('email-already-in-use');

          expect(result, 'Email already in use');
        },
      );
    },
  );
}
