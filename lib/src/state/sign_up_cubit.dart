import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/sign_up_response.dart';
import '../repos/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo _repo;
  SignUpCubit(this._repo) : super(SignUpInitial());

  Future<void> signUp({
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required int genderId,
    required String countryCode,
  }) async {
    emit(SignUpLoading());
    final res = await _repo.signUp(
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      genderId: genderId,
      countryCode: countryCode,
    );
    res.fold(
          (fail) => emit(SignUpFailure(fail.errMessage)),
          (resp) => emit(SignUpSuccess(resp)),
    );
  }
}