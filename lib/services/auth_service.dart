import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shamo_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shamo_app/provaiders/auth_provaider.dart';

class AuthService {
  var url = Uri.https('5f6e-103-121-22-5.ngrok-free.app', 'api/register');
  Future<UserModel> register({
    required String name,
    required String email,
    required String username,
    required String password,
  }) async {
    var headers = {
      'Content-type': 'application/json',
    };
    var body = jsonEncode({
      'name': name,
      'email': email,
      'username': username,
      'password': password,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      UserModel user = UserModel.fromJson(data['user']);

      user.token = 'Bearer ${data['access_token']}';
      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.https('5f6e-103-121-22-5.ngrok-free.app', 'api/login');
    // var url = '$baseUrl/api/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    // ignore: avoid_print
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['user'];
      var token = jsonDecode(response.body)['data']['access_token'];

      UserModel user = UserModel.fromJson(data);
      // print(user);
      user.token = "Bearer $token";
      return user;
    } else {
      throw Exception("Gagal Login");
    }
  }

  // Future<UserModel> logout() async {
  //   var url = Uri.https('5f6e-103-121-22-5.ngrok-free.app', 'api/logout');
  //   var headers = {'Content-Type': 'application/json'};
  //
  //   var response = await http.post(url, headers: headers);
  //
  //   AuthProvaider authProvaider = Provider.of<AuthProvaider>(context);
  //   // UserModel user authProvaider.user;
  //
  //   if(user){
  //
  //   }
  //
  //   return user;
  // }
}
