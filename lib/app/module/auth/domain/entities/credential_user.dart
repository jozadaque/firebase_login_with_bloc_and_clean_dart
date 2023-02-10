import 'package:equatable/equatable.dart';

class CredentialUser extends Equatable {
  final String email;
  final String uuid;

  const CredentialUser({
    required this.email,
    required this.uuid,
  });

  @override
  List<Object?> get props => [email, uuid];
}
