class FirebaseErrors {
  static convertMessageError(String message) {
    if (message == 'email-already-exists') {
      return 'E-mail já Cadastrado';
    }

    if (message == 'invalid-email') {
      return 'E-mail inválido';
    }

    if (message == 'invalid-password') {
      return 'Senha inválida';
    }

    if (message == 'email-already-in-use') {
      return 'E-mail já esta em uso';
    }

    if (message == 'wrong-password') {
      return 'Senha Incorreta';
    }

    if (message == 'user-not-found') {
      return 'E-mail não encontrado';
    }

    return message;
  }
}
