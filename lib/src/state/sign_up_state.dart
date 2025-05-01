part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  @override List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {
  final SignUpResponse response;
  const SignUpSuccess(this.response);
  @override List<Object?> get props => [response];
}
class SignUpFailure extends SignUpState {
  final String error;
  const SignUpFailure(this.error);
  @override List<Object?> get props => [error];
}