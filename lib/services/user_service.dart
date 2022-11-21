import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Modelos/Modelo_User.dart';
import '../Modelos/Modelo_User_Login.dart';

class UserServiceProvider with ChangeNotifier {
  bool _autenticando = false;
  late User user;

  UserServiceProvider(
      );

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get autenticando => this._autenticando;

  set autenticando( bool valor ) {
    this._autenticando = valor;
    notifyListeners();
  }


  /*static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }*/

  Future<bool> login( String email, String password ) async {
    this.autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    final uri = Uri.parse('10.0.2.2:5193/Postulant/Login');

    final resp = await http.post( uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
    );

    this.autenticando=false;

    if (resp.statusCode == 200)
    {
      final loginResponse = userLoginFromJson(resp.body);
      this.user = loginResponse.data.postulant;

      /*this._guardarToken(loginResponse.data.token);*/
      return true;
    }
    else{
      return false;
    }
  }

  /*
  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }*/

  Future<User> updatePostulant(User user) async {
    notifyListeners();

      this.user = user;
      final url = Uri.http( '10.0.2.2:5193', '/api/Postulant/Update');
      final resp = await http.put(
          url,
          body: this.user.toJson(),
          headers: {
            'Content-Type': 'application/json'
          });
      final decodedData = resp.body;
      print(decodedData);


    notifyListeners();
    return this.user;
  }
}