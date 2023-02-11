class FirebaseErrors {
  static convertMessageError(String message) {
    if (message == 'email-already-exists') {
      return 'Email already exists';
    }

    if (message == 'invalid-email') {
      return 'Invalid Email';
    }

    if (message == 'invalid-password') {
      return 'Invalid password';
    }

    if (message == 'email-already-in-use') {
      return 'Email already in use';
    }

    if (message == 'wrong-password') {
      return 'Wrong password';
    }

    if (message == 'user-not-found') {
      return 'User not found';
    }

    return message;
  }
}
