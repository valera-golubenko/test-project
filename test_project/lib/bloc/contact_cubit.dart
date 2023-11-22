import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:test_project/api/app_api.dart';
import 'package:test_project/models/contact_model.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final AppApi _api;
  ContactCubit(this._api) : super(const ContactState());

  set setName(String value) {
    emit(state.copyWidth(name: value, enableValidation: false));
  }

  set setEmail(String value) {
    emit(state.copyWidth(email: value, enableValidation: false));
  }

  set setMessage(String value) {
    emit(state.copyWidth(message: value, enableValidation: false));
  }

  Future<void> sendCredentials(ValueSetter<String> errorHandler) async {
    emit(state.copyWidth(enableValidation: true));

    if (!state.readyToSend) return;

    emit(state.copyWidth(loading: true));
    final result = await _api.sendData(state.toRequest);

    emit(state.copyWidth(loading: false));

    if (result.statusCode == 201) return;

    final map = _decoder(result);

    final message = map['email'];

    if (message is List) return errorHandler(message.join('\n'));

    errorHandler('$message');
  }

  Map<String, dynamic> _decoder(Response response) {
    final result = jsonDecode(response.body);

    if (result is! Map<String, dynamic>) return {};

    return result;
  }
}
