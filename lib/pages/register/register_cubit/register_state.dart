part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState
{
  final String uId;

  RegisterSuccess(this.uId);
}

class RegisterError extends RegisterState
{
  final String error;

  RegisterError(this.error);
}

class RegisterCreateUserSuccess extends RegisterState {}

class RegisterCreateUserError extends RegisterState
{
  final String error;

  RegisterCreateUserError(this.error);
}

class RegisterPassVisibility extends RegisterState {}
