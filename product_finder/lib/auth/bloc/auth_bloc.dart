import 'dart:async';
import 'package:product_finder/auth/user_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _authRepo = UserAuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<VerifyAuthEvent>(_authVerification);
    on<AnonymousAuthEvent>(_authAnonymous);
    on<EmailAuthEvent>(_authEmail);
    on<EmailRegEvent>(_regEmail);
    on<GoogleAuthEvent>(_authGoogle);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _authVerification(event, emit) {
    if (_authRepo.isAlreadyAuthenticated()) {
      emit(AuthSuccessState());
    } else {
      emit(UnAuthState());
    }
  }

  FutureOr<void> _authAnonymous(event, emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepo.signInAnonymous();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(eMsg: "Ha ocurrido un error en login anonimo."));
    }
  }

  FutureOr<void> _authEmail(EmailAuthEvent event, Emitter emit) async {
    emit(AuthLoadingState());
    try {
      // await _authRepo.signInWithEmail(event.email, event.pass);
      // emit(AuthSuccessState());
      if (await _authRepo.signInWithEmail(event.email, event.pass)) {
        emit(AuthSuccessState());
      } else {
        emit(AuthErrorState(eMsg: "Ha ocurrido un error en email auth."));
      }
    } catch (e) {
      emit(AuthErrorState(eMsg: "Ha ocurrido un error en email auth."));
    }
  }

  FutureOr<void> _regEmail(EmailRegEvent event, Emitter emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepo.regEmail(event.email, event.pass);
      emit(AuthSuccessState());
      // if (await _authRepo.signInWithEmail(event.email, event.pass)) {
      //   emit(AuthSuccessState());
      // } else {
      //   emit(AuthErrorState(eMsg: "Ha ocurrido un error en email auth."));
      // }
    } catch (e) {
      emit(AuthErrorState(eMsg: "Ha ocurrido un error al registrar email."));
    }
  }

  FutureOr<void> _authGoogle(event, emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepo.signInWithGoogle();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(eMsg: "Ha ocurrido un error en login con Google."));
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      await _authRepo.signOutFirebaseUser();
    } else {
      await _authRepo.signOutFirebaseUser();
      await _authRepo.signOutGoogleUser();
    }
    emit(SignOutSuccessState());
  }
}
