import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sign_up_response.dart';
import '../repos/auth_repo.dart';
import 'auth_providers.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {
  final SignUpResponse response;
  const SignUpSuccess(this.response);
  @override
  List<Object?> get props => [response];
}
class SignUpFailure extends SignUpState {
  final String error;
  const SignUpFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  final AuthRepo _repo;

  SignUpNotifier(this._repo) : super(SignUpInitial());

  Future<void> signUp({
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required int genderId,
    required String countryCode,
  }) async {
    state = SignUpLoading();
    final res = await _repo.signUp(
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      genderId: genderId,
      countryCode: countryCode,
    );

    res.fold(
          (fail) => state = SignUpFailure(fail.errMessage),
          (resp) => state = SignUpSuccess(resp),
    );
  }
}

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return SignUpNotifier(authRepo);
});