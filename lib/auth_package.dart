library auth_package;

// Core exports
export 'src/config/auth_config.dart';
export 'src/utils/api_service.dart';
export 'src/errors/failure.dart';

// Models exports
export 'src/models/otp_response.dart';
export 'src/models/confirm_otp_response.dart';
export 'src/models/sign_up_response.dart';

// Repository exports
export 'src/repos/auth_repo.dart';
export 'src/repos/auth_repo_impl.dart';

// Business logic / state management exports
export 'src/state/otp_cubit.dart';
export 'src/state/confirm_otp_cubit.dart';
export 'src/state/sign_up_cubit.dart';

// Package initialization
export 'src/auth_package.dart';