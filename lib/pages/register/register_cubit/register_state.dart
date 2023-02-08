part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}

class VerificationLoading extends RegisterState {}
class VerificationSuccess extends RegisterState {
  final bool isEmailVerified;
  final String uId;

  VerificationSuccess(this.uId,this.isEmailVerified);
}
class VerificationTrue extends RegisterState {
  final String uId;

  VerificationTrue(this.uId);
}

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

class RegisterCreateUserSuccess extends RegisterState {
  final String uId;

  RegisterCreateUserSuccess(this.uId);
}

class RegisterCreateUserError extends RegisterState
{
  final String error;

  RegisterCreateUserError(this.error);
}

class RegisterPassVisibility extends RegisterState {}
