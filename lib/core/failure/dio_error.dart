


// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

class DioExceptions  {
final String message;

   DioExceptions(this.message);
 
  

   factory DioExceptions.fromDioError( DioError dioError) {  
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
    return   DioExceptions( "Connection timeout. Please try again later.");
      case DioErrorType.sendTimeout:
      return  DioExceptions( "Send timeout. Please try again later.");
      case DioErrorType.receiveTimeout:
      return  DioExceptions( "Receive timeout. Please try again later.");
      case DioErrorType.badResponse:
      return  DioExceptions( handleResponseError(dioError.response!.statusCode));
       
      case DioErrorType.cancel:
      "Request to the server was cancelled.";
        break;
      case DioErrorType.connectionError:
      return  DioExceptions( "Network issue. Please check your connection.");
     
      default:
    return    DioExceptions( "Unexpected error occurred.");
       
    }
    throw Exception(dioError.message);
  }


  static String handleResponseError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request.";
      case 401:
        return "Unauthorized. Please check your credentials.";
      case 403:
        return "Forbidden request.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Internal server error.";
      case 502:
        return "Bad gateway.";
      case 503:
        return "Service unavailable.";
      default:
        return "Received invalid status code: $statusCode";
    }
  }

  @override
  String toString() => message;
}
