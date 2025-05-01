# my_custom_package

A reusable Flutter package providing OTP & authentication models, repository, and BLoC/Cubit for Sign‑Up flows over Dio.

## Features
- `OtpResponse`, `ConfirmOtpResponse`, `SignUpResponse` models
- `AuthRepo` interface + `AuthRepoImpl` using Dio
- `SignUpCubit` with `SignUpState`

## Installation
Add to your app's `pubspec.yaml`:
```yaml
dependencies:
  auth_package:
    git:
      url: https://github.com/shamshussein/auth_package.git
      ref: v0.1.0