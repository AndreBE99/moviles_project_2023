part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyAuthEvent extends AuthEvent {}

class AnonymousAuthEvent extends AuthEvent {}

class EmailAuthEvent extends AuthEvent {
  final String email;
  final String pass;

  EmailAuthEvent({required this.email, required this.pass});

  @override
  List<Object> get props => [email, pass];
}

class EmailRegEvent extends AuthEvent {
  final String email;
  final String pass;

  EmailRegEvent({required this.email, required this.pass});

  @override
  List<Object> get props => [email, pass];
}

class GoogleAuthEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
