part of 'contact_cubit.dart';

@immutable
class ContactState {
  final String name;
  final String email;
  final String message;
  final bool enableValidation;
  final bool loading;
  final String status;

  const ContactState({
    this.name = '',
    this.email = '',
    this.message = '',
    this.enableValidation = false,
    this.loading = false,
    this.status = '',
  });

  ContactState copyWidth({
    String? name,
    String? email,
    String? message,
    bool? enableValidation,
    bool? loading,
    String? status,
  }) {
    return ContactState(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
      enableValidation: enableValidation ?? this.enableValidation,
      loading: loading ?? this.loading,
      status: status ?? this.status,
    );
  }

  bool get nameValidation {
    return enableValidation ? name.isNotEmpty : true;
  }

  bool get emailValidation {
    final bool valid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return enableValidation ? valid : true;
  }

  bool get messageValidation {
    return enableValidation ? message.isNotEmpty : true;
  }

  bool get buttonEnable {
    if (name.isNotEmpty && email.isNotEmpty && message.isNotEmpty) return true;
    return false;
  }

  bool get readyToSend {
    return [
      nameValidation,
      emailValidation,
      messageValidation,
    ].every((e) => e);
  }

  ContactRequestModel get toRequest {
    return ContactRequestModel(
      name: name,
      email: email,
      message: message,
    );
  }
}
