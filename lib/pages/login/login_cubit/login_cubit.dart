import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoading());

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccess(value.user!.uid));
    }).catchError((error)
    {
      emit(LoginError(error.toString()));
    });

  }

  IconData suffix = Icons.remove_red_eye;
  bool isPassShown = true;

  void passVisibility()
  {
    isPassShown = !isPassShown;
    suffix = isPassShown ?
    Icons.visibility_outlined :
    Icons.visibility_off_outlined;

    emit(LoginPassVisibility());
  }
}
