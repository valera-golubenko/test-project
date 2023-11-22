import 'package:http/http.dart';
import 'dart:convert';

import '../models/contact_model.dart';

class AppApi {
  Future<Response> sendData(ContactRequestModel model) async {
    final response =
        await post(Uri.parse('https://api.byteplex.info/api/test/contact/'),
            body: json.encode({
              'name': model.name,
              'email': model.email,
              'message': model.message,
            }),
            headers: {'Content-Type': 'application/json'});

    return response;
  }
}
