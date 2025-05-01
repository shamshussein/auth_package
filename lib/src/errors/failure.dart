import 'package:dio/dio.dart';

abstract class Failure{
final String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure{
ServerFailure(super.errMessage);

factory ServerFailure.fromDioError(DioError dioError){
  switch(dioError.type) {
    case DioExceptionType.connectionTimeout:
      return ServerFailure('Connection timeout with ApiServer');
    case DioExceptionType.sendTimeout:
      return ServerFailure('Send timeout with ApiServer');
    case DioExceptionType.receiveTimeout:
      return ServerFailure('Receive timeout with ApiServer');
    case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      throw UnimplementedError();
    case DioExceptionType.badResponse:
      return ServerFailure.fromResponse(dioError.response!.statusCode!, dioError.response!.data);
    case DioExceptionType.cancel:
      return ServerFailure('Request to ApiServer was canceled');
    case DioExceptionType.connectionError:
      // TODO: Handle this case.
      throw UnimplementedError();
    case DioExceptionType.unknown:
      if (dioError.message!.contains('Socket Exception')){
        return ServerFailure('No internet connection');
      }
      return ServerFailure('Unexpected Error');
    }
}

factory ServerFailure.fromResponse(int statusCode, dynamic response){
  if(statusCode == 400 || statusCode == 401 || statusCode==403){
    return ServerFailure(response['error']['errorMessage']);
  }else if(statusCode == 404){
   return ServerFailure('Your request not found, please try again later!');
  }else if(statusCode == 500){
    return ServerFailure('Internal Server Error, please try again later!');
  }else{
    return ServerFailure('Oops, There was an Error, please try again!');
  }
}
}