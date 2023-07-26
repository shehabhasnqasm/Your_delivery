import 'dart:io';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  //
  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl; // baseUrl is a String parameter  from
    //from GetConnect
    timeout = const Duration(seconds: 300);
    //timeout is a Duration parameter  from GetConnect
    // token = AppConstants.token; //token is a String parameter  from GetConnect
    token = sharedPreferences.getString(AppConstants.token) ?? "";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer  $token',
    };
  }
//-----------------------------------------------------------
  Future<Response> getData(String url, {Map<String, String>? header}) async {
    late Response response;
    try {
      response = await get(url, headers: header ?? _mainHeaders);
      // return response;
    } on HttpException catch (e) {
      throw Exception(e.message);
    } on SocketException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    } finally {
      return response;
    }
  }

  //////////////////////////////////
  //-----------------------------------------------------------
  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  /////////////////////////////
//-----------------------------------------------------------
  void updateHeader(String aToken) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer  $aToken',
    };
  }
  //-----------------------------------------------------------
}
